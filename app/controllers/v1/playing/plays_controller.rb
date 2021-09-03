module V1::Playing
  class PlaysController < BaseController
    before_action :authenticate_user!
    before_action :set_play, except: [:set]

    # 현재 스테이지 목록
    def stage_lists
      if params[:after].to_i > 0
        data = @play.stage_lists.includes({
          translations: [],
          stages: [:audios, :videos, :images, :translations]
        }).offset(params[:after].to_i)
      else
        data = @play.stage_lists.includes({
          translations: [],
          stages: [:audios, :videos, :images, :translations]
        })
      end

      # if params[:stages]
      #   data = data.as_json(:play)
      # end

      render json: {
        data: data.as_json(:play)
      }
    end

    def detail
      # @play = Play.where(id: @play.id)
      #   .includes()
      #   .take
      render json: {
        data: @play.as_json(:play),
      }
    end

    def set
      # TODO: 플레이가 있는지, 권한이 있는지.
      session[:play_id] = params[:play_id].to_i
      set_play
      set_data(@play)
      respond("성공")
    end

    def answer
      raise_error("종료된 플레이", 4000) unless @play.playing?
      raise_error("지니간 스테이지임", 4001) if @play.stage_lists.last.id != params[:stage_list_id].to_i

      correct, _branch = @play.submit_answer(params[:answer])

      if correct
        respond("정답 맞춤", 2000)
      else
        respond("틀림", 2001)
      end
    end

    def hint
      raise_error("종료된 플레이", 4000) unless @play.playing?
      raise_error("지니간 스테이지임", 4001) if @play.stage_lists.last.id != params[:stage_list_id].to_i
      
      hint, result, message = @play.use_hint(params[:hint_number].to_i)

      unless result
        raise_error(message, 4002)
      else
        set_data(hint)
        respond(message, 2000)
      end
    end

    def on_stage
      # stage_index:
    end

    private
      def set_play
        Model.current.play = Model::Play::Base.find(session[:play_id])
        # Model.current.play = Model::Play::Base.find(params[:id])
        @play ||= Model.current.play
      end
  end
end
