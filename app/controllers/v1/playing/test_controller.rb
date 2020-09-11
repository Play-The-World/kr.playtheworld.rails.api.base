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

    def next_stage_list
      @play.go_next!
      # set_data(@play.tracks.last.as_json(:play))
      respond("성공")
    end

    def submit_answer
      raise_error("종료된 플레이", 400) unless @play.playing?
      raise_error("지니간 스테이지임", 401) if @play.stage_lists.last.id != params[:stage_list_id].to_i

      if @play.submit_answer(params[:answer])
        respond("정답 맞춤", 200)
      else
        respond("틀림", 201)
      end
    end

    def on_stage
      if @play.on_stage(stage_index: params[:stage_index], stage_list_index: params[:stage_list_index])
        respond("성공")
      else
        raise_error("실패")
      end
    end

    private
      def set_user
        user = Model::User::Base.first
        user ||= Model::User::Base.create!(
          email: "mechuri@playthe.world",
          password: "123456",
          password_confirmation: "123456"
        )
        Model.current.user = user
        session[:user_id] = user.id
      end
      def set_play
        # TEST에서 session이 잘 안되서..
        Model.current.play = Model::Play::Base.last
        # Model.current.play = Model::Play::Base.find(session[:play_id])
        @play ||= Model.current.play
      end
  end
end
