module V1::Making
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
      @pagy, @super_themes = pagy(data)
      render json: {
          data: @super_themes.as_json(:images),
          meta: { total: data.size }
        }
    end

    # GET /:id
    def show
      render json: {
        data: @super_theme.as_json(:detail)
      }
    end

    # POST /
    def create
      
    end

    # PATCH/PUT /:id
    def update
    end

    # DELETE /:id
    def destroy
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