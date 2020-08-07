module V1
  class TestsController < BaseController
    # skip_before_action :authenticate_user!, only: [:create]
  
    # GET /tests
    def index
      render json: []
    end
  
    # POST /tests
    def create
      # if user_params[:name].nil? or user_params[:name].empty?
      #   render json: { error: "잘못된 이름입니다." }, status: :unprocessable_entity
      # else
      #   user = User.find_or_create_by(name: user_params[:name])
      #   sign_in user
      #   render json: UserSerializer.new(user).serialized_json
      # end
      render json: []
    end
  
    # GET /users
    def show
      render json: []
    end
  
    # DELETE /users
    def destroy
      render json: []
    end

    def ping
      render json: { message: "pong" }
    end
  
    private
      def permit_params
        params.require(:user).permit(:name)
      end
  end
end