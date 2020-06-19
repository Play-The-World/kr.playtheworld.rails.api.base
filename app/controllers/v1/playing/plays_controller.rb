module V1::Playing
  class PlaysController < BaseController
    before_action :authenticate_user!
    before_action :set_play, except: [:set]

    # 현재 스테이지 목록
    def stage_lists
      render json: {
        data: @play.stage_lists
      }
    end

    def detail
      render json: {
        data: @play.as_json(:playing),
      }
    end

    def set
      # TODO: 플레이가 있는지, 권한이 있는지.
      session[:play_id] = params[:play_id].to_i
      set_play
      set_data(@play)
      respond("성공")
    end

    private
      def set_play
        Model.current.play = Model::Play::Base.find(session[:play_id])
        # Model.current.play = Model::Play::Base.find(params[:id])
        @play ||= Model.current.play
      end
  end
end
