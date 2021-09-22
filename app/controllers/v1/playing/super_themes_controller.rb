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
      @pagy, @super_themes = pagy(data)
      render json: {
          data: @super_themes.as_json(:images),
          meta: { total: data.size }
        }
    end

    # GET /:id
    def show
      if @super_theme.type == Model::SuperTheme::Crime.to_s
        data = @super_theme.as_json(:crime_show)
      else
        data = @super_theme.as_json(:show)
      end
      render json: {
        data: data
      }
    end

    private
      def set_super_theme
        @super_theme = constant.where(fake_id: params[:id]).or(constant.where(id: params[:id]))
          .includes(
            themes: {
              images: {
                # file: :blob
              }
            }
          )
          .take
      end

      def constant
        Model.config.super_theme.constant
      end
  end
end