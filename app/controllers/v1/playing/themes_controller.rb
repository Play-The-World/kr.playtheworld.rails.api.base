module V1::Playing
  class ThemesController < BaseController
    before_action :set_theme, only: [:show, :play]

    Theme = Model::Theme

    def show
      @theme = Theme::Base.first
      # json = @theme.serializer.new(@theme, include: [:super_theme]).serializable_hash
      json = ::Model::Serializer::Theme.new(@theme, include: [:super_theme]).serializable_hash
      # render json: @theme.as_json()
      render json: json
    end

    def play
      if play = current_user.play_solo(theme: @theme)
        set_data(play.as_json)
        respond("플레이 시작")
      else
        raise_error("안됨")
      end
    # rescue
    #   render json: {}
    end

    private
      def user_params
        params.fetch(:query, {}).permit(:title, :categories, :genres)
      end

      def set_theme
        @theme = Model::Theme::Base.includes(:super_theme).find_by(fake_id: params[:id])
        @super_theme = @theme&.super_theme
      end
  end
end
