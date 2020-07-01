module V1::Playing
  class SessionsController < BaseController
    before_action :authenticate_user!, only: [:confirm_email, :sign_out, :update_nickname]
    User = ::Model::User

    # 이메일 가입여부 확인
    def email
      # TODO: EMAIL주소 올바른지 확인 필요.
      # raise_error("올바르지 않은 이메일 주소")
      if User::Base.where(email: user_params[:email]).exists?
        respond("가입된 이메일")
      else
        respond("아직 가입 안된 이메일", 2001)
      end
    end

    # 이메일 인증
    def confirm_email
      if current_user.status != :unauthorized
        raise_error("잘못된 요청", 4000)
      elsif current_user.confirm_email(user_params[:email_confirmation])
        respond("성공")
      else
        raise_error("잘못된 인증번호", 4001)
      end
    end

    # 로그인
    def sign_in
      raise_error("이미 로긴", 4000) unless current_user.nil?

      user = User.find_by(email: user_params[:email])
      # 유저 없음.
      raise_error("아직 가입되지 않은 이메일입니다.", 4001) if user.nil?

      # TODO: 이메일 인증 받았는지 등. 분기 처리 많이 필요할 듯.
      if user.valid_password?(user_params[:password])
        # 로그인 성공
        reset_session
        session[:user_id] = user.id
        respond("성공적으로 로그인되었습니다.")
      else
        # 비번틀림
        raise_error("비밀번호가 틀렸습니다.", 4002)
      end
    end

    # 가입
    def sign_up
      # TODO 올바른 이메일 체크
      # raise_error("올바르지 않은 이메일 주소", 4000)

      if User.where(email: user_params[:email]).exists?
        # 이미 가입된 이메일
        raise_error("이미 가입된 이메일입니다.", 4001)
      else
        # TODO 비번 양식 확인
        # raise_error("올바르지 않은 비번 양식", 4002)

        user = User.new(email: user_params[:email], password: user_params[:password], password_confirmation: user_params[:password])
        if user.save
          # 가입 성공 + 로그인
          session[:user_id] = user.id
          respond("성공적으로 가입되었습니다.")
        else
          # 뭔가 에러 생김.
          raise_error
        end
      end
    end

    # 로그아웃
    def sign_out
      if session[:user_id]
        # 로그아웃
        # session.delete(:user_id)
        reset_session
        respond("로그아웃 성공")
      else
        # 로그인되어 있지 않음
        raise_error("로그인 안되있음.", 4000)
      end
    end

    def update_nickname
      if current_user.nickname == user_params[:nickname]
        respond("변경 사항 없음.")
      elsif current_user.update(nickname: user_params[:nickname])
        respond("닉네임 변경 성공", 2001)
      else
        # 뭔가 에러
        raise_error
      end
    end

    def update_password
      # TODO 비번 양식 확인
      # raise_error("올바르지 않은 비번 양식")

      raise_error("불일치", 4001) if user_params[:password] != user_params[:password_confirmation]

      if current_user.update(password: user_params[:password], password_confirmation: user_params[:password])
        respond("비번 변경 성공.")
      else
        # 뭔가 에러
        raise_error
      end
    end

    def update_email
      # TODO 올바른 이메일 체크
      # raise_error("올바르지 않은 이메일 주소", 4000)

      if current_user.email == user_params[:email]
        respond("변경사항 없음", 2001)
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
