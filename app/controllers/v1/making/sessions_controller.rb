module V1::Making
  class SessionsController < BaseController
    skip_before_action :authenticate_user!, except: [:update_nickname]
    # skip_before_action :verify_authenticity_token, only: [:sign_out]
    # before_action :authenticate_user!, only: [:confirm_email, :sign_out, :update_nickname]
    User = ::Model::User

    def current_user_data
      set_data_user
      respond("현재 유저 정보")
    end

    # 이메일 가입여부 확인
    def email
      raise_error("이메일 주소를 입력해주세요.", 404) if user_params[:email].nil?
      # TODO: EMAIL주소 올바른지 확인 필요.
      # raise_error("올바르지 않은 이메일 주소")
      if User::Base.where(email: user_params[:email]).where.not(status: :unauthorized).exists?
        respond("가입된 이메일", 201)
      else
        reset_session
        session[:email] = user_params[:email]
        # set_data_user
        respond("아직 가입 안된 이메일", 200)
      end
    end

    # 이메일 인증
    def confirm_email
      # 로그인 안된 경우
      if current_user.nil?
        email = user_params[:email] || session[:email]
        user = User::Base.find_by(email: email)
        raise_error("해당 유저를 찾을 수 없습니다.", 404) if user.nil?

        if user.confirm_email(user_params[:email_confirmation])
          # 로그인 성공
          reset_session
          session[:user_id] = user.id
          respond("성공")
        else
          raise_error("잘못된 인증번호", 403)
        end
      else
        if current_user.status != "unauthorized"
          raise_error("잘못된 요청", 400)
        elsif current_user.confirm_email(user_params[:email_confirmation])
          respond("성공")
        else
          raise_error("잘못된 인증번호", 403)
        end
      end
    end

    # 로그인
    def sign_in
      # raise_error("이미 로긴", 400) unless current_user.nil?

      user = User::Base.where(email: user_params[:email]).where.not(status: :unauthorized).take
      # 유저 없음.
      raise_error("아직 가입되지 않은 이메일입니다.", 404) if user.nil?

      # TODO: 이메일 인증 받았는지 등. 분기 처리 많이 필요할 듯.
      if user.valid_password?(user_params[:password])
        # 로그인 성공
        reset_session
        session[:user_id] = user.id
        respond("성공적으로 로그인되었습니다.")
      else
        # 비번틀림
        raise_error("비밀번호가 틀렸습니다.", 401)
      end
    end

    # 가입
    def sign_up
      # raise_error("이미 로긴", 400) unless current_user.nil?

      # TODO 올바른 이메일 체크
      # raise_error("올바르지 않은 이메일 주소", 4000)
      user = User::Base.where(email: user_params[:email]).take
      if !user.nil? and !user.unauthorized?
        # 이미 가입된 이메일
        raise_error("이미 가입된 이메일입니다.", 403)
      else
        # TODO 비번 양식 확인
        # raise_error("올바르지 않은 비번 양식", 4002)

        user = User::Base.new if user.nil?
        user.email = user_params[:email]
        user.password = user_params[:password]
        user.password_confirmation = user_params[:password]

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
      # 로그아웃
      session[:user_id] = nil
      session.delete(:user_id)
      reset_session
      # puts "session!"
      # puts session.inspect
      respond("로그아웃 성공")
    end

    def update_nickname
      if current_user.nickname == user_params[:nickname]
        respond("변경 사항 없음.", 202)
      elsif User::Base.where(nickname: user_params[:nickname]).exists?
        raise_error("중복된 닉네임입니다.", 400)
      else
        if current_user.update(nickname: user_params[:nickname])
          # 일단 여기다가 넣음.
          current_user.update!(status: :default)
          respond("닉네임 변경 성공", 200)
        else
          # 뭔가 에러
          raise_error
        end
      end
    end

    def update_password
      # TODO 비번 양식 확인
      # raise_error("올바르지 않은 비번 양식")

      raise_error("불일치", 400) if user_params[:password] != user_params[:password_confirmation]

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
        respond("변경사항 없음", 202)
      else
        user = User::Base.find_by(email: user_params[:email])

        raise_error("중복된 이메일입니다.", 403) if !user.nil? and user.status != "unauthorized"
        
        user.destroy unless user.nil?
        if current_user.update(email: user_params[:email])
          respond("이메일 변경 성공.")
        else
          # 뭔가 에러
          raise_error
        end
      end
    end

    def test
      render json: session
    end

    private
      def set_data_user
        user = {
          email: session[:email]
        }
        unless current_user.nil?
          user[:id] = current_user.id
          user[:nickname] = current_user.nickname
          user[:email] = current_user.email
          user[:status] = current_user.status
        end
        set_data({
          user: user
        })
      end
  end
end
