module V1::Playing
  class TestController < BaseController
    # before_action :authenticate_user!
    # zbefore_action :set_play, except: [:set]
    before_action :set_user
    before_action :set_play, except: [:new_play]

    # POST
    def new_play
      # 냥토리얼
      theme = Model::SuperTheme::Base.where(title: "냥토리얼").take.themes.take
      play = current_user.play_solo(theme: theme)
      session[:play_id] = play.id

      set_data(play.as_json(:play))
      respond("성공")
    end

    # 현재 스테이지 목록
    def stage_lists
      if params[:after].to_i > 0
        data = @play.stage_lists.offset(params[:after].to_i)
      else
        data = @play.stage_lists
      end

      if params[:stages] == "true"
        data = data.as_json(:stages)
      end

      render json: {
        data: data
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

    def answer
      raise_error("종료된 플레이", 4000) unless @play.playing?
      raise_error("지니간 스테이지임", 4001) if @play.stage_lists.last.id != params[:stage_list_id].to_i

      if @play.submit_answer(params[:answer])
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
      def set_user
        user = Model::User::Base.first
        user ||= Model::User::Base.create!(
          email: "mechuri@playthe.world",
          password: "123456",
          password_confirmation: "123456"
        )
        sign_in(user)
      end
      def set_play
        Model.current.play = Model::Play::Base.find(session[:play_id])
        # Model.current.play = Model::Play::Base.find(params[:id])
        @play ||= Model.current.play
      end
  end
end
