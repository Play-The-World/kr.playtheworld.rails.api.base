module V1::Playing
  class PlaysController < BaseController
    before_action :authenticate_user!
    before_action :set_play

    def current_stage_lists
      render json: @play.current_stage_lists
    end

    private
      def set_play
        Model.current.play = Model::Play.find(session[:play_id])
        @play = Model.current.play
      end
  end
end
