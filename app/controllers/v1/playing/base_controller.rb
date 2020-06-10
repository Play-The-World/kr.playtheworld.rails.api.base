module V1::Playing
  class BaseController < ::V1::BaseController
    before_action :authenticate_user
    before_action :authenticate_user!
    
    def test
    end

    private
      def authenticate_user
        @user = current_user
      end
      def authenticate_user!
        if current_user.nil?
          render json: {
              message: "로그인 필요.",
              code: 1000
            }, status: :unauthorized
        end
      end
      
      def current_user
        # Model.current.user ||= Model::User.find(session[:user_id])
        Model::User.find_by(id: session[:user_id])
      end
  end
end
