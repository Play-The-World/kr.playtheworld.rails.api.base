module V1
  class PlayController < BaseController
    # skip_before_action :authenticate_user!, only: [:create]
    
    def create
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
  
    private
      def set_current_play
        @play = Model.config.play.constant.find(params[:id])
      end
  end
end