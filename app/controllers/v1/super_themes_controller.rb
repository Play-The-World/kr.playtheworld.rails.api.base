module V1
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
      @pagy, @super_themes = pagy(data)
      render json: {
          data: @super_themes.as_json(:detail),
          meta: { total: data.size }
        }
    end

    # GET /:id
    def show
      render json: @super_theme.as_json(:detail)
    end

    private
      def set_super_theme
        @super_theme = constant.find_by_fake_id(params[:id])
      end

      def constant
        Model.config.super_theme.constant
      end
  end
end