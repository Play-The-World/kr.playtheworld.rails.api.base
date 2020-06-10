module V1::Playing
  class SessionsController < BaseController
    skip_before_action :authenticate_user!, except: [:confirm_email, :sign_out, :update_nickname]
    User = ::Model::User

    # 이메일 가입여부 확인
    def email
      # TODO: EMAIL주소 올바른지 확인 필요.
      if User.where(email: user_params[:email]).exists?
        # 가입됨
        render json: {
            message: "가입된 이메일",
            code: 2000
          }, status: :ok
      else
        # 가입안됨.
        render json: {
            message: "아직 가입 안된 이메일",
            code: 2001
          }, status: :ok
      end
    end

    # 이메일 인증
    def confirm_email
      user = current_user

      if user.confirm_email(user_params[:email_confirmation])
        # 됨
        render json: {
            message: "성공",
            code: 2000
          }, status: :ok
      else
        # 안됨
        render json: {
            message: "잘못된 인증번호",
            code: 4000
          }, status: :bad_request
      end
    end

    # 로그인
    def sign_in
      unless current_user.nil?
        render json: {
            message: "이미 로긴",
            code: 4001
          }, status: :bad_request
        return
      end

      user = user_by_email

      if user.nil?
        # 유저 없음.
        render json: {
            message: "아직 가입되지 않은 이메일입니다.",
            code: 4000
          }, status: :bad_request
      elsif user.valid_password?(user_params[:password])
        # 로그인 성공
        reset_session
        session[:user_id] = user.id
        render json: {
            mesage: "성공적으로 로그인되었습니다.",
            code: 2000
          }, status: :ok
      else
        # 비번틀림
        render json: {
            message: "비밀번호가 틀렸습니다.",
            code: 4001
          }, status: :bad_request
      end
    end

    # 가입
    def sign_up
      # TODO 올바른 이메일 체크
      if User.where(email: user_params[:email]).exists?
        # 이미 가입된 이메일
        render json: {
            message: "이미 가입된 이메일입니다.",
            code: 4000
          }, status: :bad_request
      else
        # TODO 비번 체크
        user = User.new(email: user_params[:email], password: user_params[:password], password_confirmation: user_params[:password])
        if user.save
          # 가입 성공 + 로그인
          session[:user_id] = user.id
          render json: {
              message: "성공적으로 가입되었습니다.",
              code: 2000
            }, status: :ok
        else
          # 뭔가 에러 생김.
          render json: {
              message: "뭔가 에러 생김.",
              code: 4001
            }, status: :bad_request
        end
      end
    end

    # 로그아웃
    def sign_out
      if session[:user_id]
        # 로그아웃
        # session.delete(:user_id)
        reset_session
        render json: {
            message: "로그아웃 성공",
            code: 2000
          }, status: :ok
      else
        # 로그인되어 있지 않음
        render json: {
            message: "로그인 안되있음.",
            code: 4000
          }, status: :bad_request
      end
    end

    def update_nickname
      user = current_user

      if user.nickname == user_params[:nickname]
        render json: {
            message: "변경 사항 없음.",
            code: 2000
          }, status: :ok
      elsif user.update(nickname: user_params[:nickname])
        render json: {
            message: "닉네임 변경 성공",
            code: 2001
          }, status: :ok
      else
        # 뭔가 에러
        render json: {
            message: "뭔가 에러남.",
            code: 4000
          }, status: :bad_request
      end
    end

    private
      def user_params
        params.fetch(:user, {}).permit(:email, :password, :nickname, :email_confirmation)
      end

      def user_by_email
        User.find_by(email: user_params[:email])
      end
  end
end
