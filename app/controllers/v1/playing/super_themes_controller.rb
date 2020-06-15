module V1::Playing
  class SuperThemesController < BaseController
    # skip_before_action :authenticate_user!, only: [:create]
    before_action :set_super_theme, except: [:index]
  
    # GET /
    def index
      data = constant.includes(
          locations: [:translations],
          genres: [:translations],
          categories: [:translations],
          # themes: [:translations],
        ).with_translations
      # data = constant.joins(
      #     locations: :translations,
      #     genres: :translations,
      #     categories: :translations,
      #     themes: :translations,
      #   ).with_translations
      # data = constant.includes(:classifications, :themes).with_translations
      options = {}
      options[:fields] = { super_theme: %i(status title summary content price data_size play_time caution genres locations categories) }
      @pagy, @super_themes = pagy(data)
      render json: {
          data: @super_themes.as_json(options),
          meta: { total: data.size }
        }
    end

    # GET /:id
    def show
      render json: @super_theme
    end

    private
      def set_super_theme
        @super_theme = constant.find(params[:id])
      end

      def constant
        Model.config.super_theme.constant
      end
  end
end