module V1::Playing
  class ThemesController < BaseController
    before_action :set_theme, only: [:show, :play]
    before_action :authenticate_user!, only: [:play]

    Theme = Model::Theme::Base

    # GET /
    def index
      set_data({
        themes: Theme.all.as_json(:show)
      })
      respond
    end

    # GET /:id
    def show
      # @theme = Theme::Base.first
      # json = @theme.serializer.new(@theme, include: [:super_theme]).serializable_hash
      # json = ::Model::Serializer::Theme.new(@theme, include: [:super_theme]).serializable_hash
      set_data({ theme: @theme.as_json(:show) })
      respond
    end

    # POST /:id/play
    def play
      if play = current_user.play_solo(theme: @theme)
        session[:play_id] = play.id
        set_data({ play: play.as_json(:base) })
        respond("플레이 시작")
      else
        raise_error("안됨")
      end
    end

    private
      def set_theme
        @theme = Theme.where(fake_id: params[:id]).or(Theme.where(id: params[:id])).includes(:super_theme).take
        raise_error("존재하지 않는 테마입니다.", 404) if @theme.nil?

        @super_theme = @theme.super_theme
      end
  end
end
