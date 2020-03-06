module V1
  class SuperThemesController < BaseController
    # skip_before_action :authenticate_user!, only: [:create]
    before_action :set_super_theme, except: [:index, :test]
  
    # GET /
    def index
      @pagy, @super_themes = pagy(constant.all)
      render json: @super_themes
    end

    # GET /:id
    def show
      render json: @super_theme
    end

    def test
      render json: {}
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