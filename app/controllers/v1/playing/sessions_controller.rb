module V1::Playing
  class SessionsController < BaseController
    before_action :authenticate_user!, only: [:confirm_email, :sign_out, :update_nickname, :agreement]
    User = ::Model::User

    def current
      if current_user
        set_data({ user: current_user })
      end
      respond
    end

    # 이메일 가입여부 확인
    def email
      unless Validate.email(user_params[:email])
        raise_error("올바르지 않은 이메일 주소입니다.", 4000)
      end
      # raise_error("올바르지 않은 이메일 주소")
      if User::Base.where(email: user_params[:email]).exists?
        respond("가입된 이메일입니다.")
      else
        respond("성공", 2001)
      end
    end

    # 이메일 인증
    def confirm_email
      # if current_user.status != :unauthorized
      #   raise_error("잘못된 요청입니다.", 4000)
      # end
      if current_user.confirm_email(user_params[:email_confirmation])
        set_data({ user: current_user })
        respond("성공")
      else
        raise_error("잘못된 인증번호입니다.", 4001)
      end
    end

    # (SNS로그인용) 약관 동의
    def agreement
      if [:done].include?(current_user.sign_up_step.to_sym)
        set_data({ user: current_user })
        respond("이미 처리되었습니다.", 2001)
        return
      end

      unless [:nickname, :agreement].include?(current_user.sign_up_step.to_sym)
        raise_error("잘못된 접근입니다.", 4001)
      end

      if current_user.update(sign_up_step: :nickname, terms_agreed_at: DateTime.now)
        set_data({ user: current_user })
        respond("성공", 2000)
      else
        # 뭔가 에러
        raise_error
      end
    end

    # 로그인
    def sign_in
      raise_error("이미 로그인되어 있습니다.", 4000) unless current_user.nil?

      user = User::Base.find_by(email: user_params[:email])
      # 유저 없음.
      raise_error("아직 가입되지 않은 이메일입니다.", 4001) if user.nil?

      # TODO: 이메일 인증 받았는지 등. 분기 처리 많이 필요할 듯.
      if user.valid_password?(user_params[:password])
        # 로그인 성공
        # reset_session
        session[:user_id] = user.id
        set_data({ user: user })
        respond("성공적으로 로그인되었습니다.")
      else
        # 비번틀림
        raise_error("비밀번호가 틀렸습니다.", 4002)
      end
    end

    # 가입
    def sign_up
      unless Validate.email(user_params[:email])
        raise_error("올바르지 않은 이메일 주소입니다.", 4000)
      end

      if User::Base.where(email: user_params[:email]).exists?
        # 이미 가입된 이메일
        raise_error("이미 가입된 이메일입니다.", 4001)
      end

      unless Validate.password(user_params[:password])
        raise_error("올바르지 않은 비밀번호 양식입니다.", 4002)
      end

      user = User::Base.new(
        email: user_params[:email],
        password: user_params[:password],
        password_confirmation: user_params[:password],
        sign_up_step: :confirmation,
      )
      if user.save
        # 가입 성공 + 로그인
        # TODO: Email 보내기
        session[:user_id] = user.id
        set_data({ user: user })
        respond("성공적으로 가입되었습니다.")
      else
        # 뭔가 에러 생김.
        raise_error
      end
    end

    # 로그아웃
    def sign_out
      if session[:user_id]
        # 로그아웃
        # session.delete(:user_id)
        reset_session
        respond("로그아웃되었습니다.")
      else
        # 로그인되어 있지 않음
        raise_error("로그인이 되어있지 않습니다.", 4001)
      end
    end

    def update_nickname
      unless Validate.nickname(user_params[:nickname])
        raise_error("올바르지 않은 닉네임 입니다.", 4000)
      end

      if ![:nickname, :done].include?(current_user.sign_up_step.to_sym)
        raise_error("잘못된 접근입니다.", 4002)
      elsif current_user.nickname == user_params[:nickname]
        respond("변경 사항이 없습니다.", 2001)
      elsif Model::User::Base.where(nickname: user_params[:nickname]).exists?
        raise_error("이미 존재하는 닉네임입니다.", 4001)
      elsif current_user.update(nickname: user_params[:nickname], sign_up_step: :done)
        set_data({ user: current_user })
        respond("닉네임 변경 성공", 2000)
      else
        # 뭔가 에러
        raise_error
      end
    end

    def update_password
      # TODO 비번 양식 확인
      # raise_error("올바르지 않은 비번 양식")

      raise_error("비밀번호가 불일치합니다.", 4001) if user_params[:password] != user_params[:password_confirmation]

      if current_user.update(password: user_params[:password], password_confirmation: user_params[:password])
        respond("비밀번호 변경 성공")
      else
        # 뭔가 에러
        raise_error
      end
    end

    def update_email
      # TODO 올바른 이메일 체크
      # raise_error("올바르지 않은 이메일 주소", 4000)

      if current_user.email == user_params[:email]
        respond("변경사항이 없습니다.", 2001)
      elsif current_user.update(email: user_params[:email])
        respond("이메일 변경 성공.")
      else
        # 뭔가 에러
        raise_error
      end
    end

    def test
      render json: session
    end

    private
      def user_params
        params.fetch(:user, {}).permit(:email, :password, :password_confirmation, :nickname, :email_confirmation)
      end
  end
end
