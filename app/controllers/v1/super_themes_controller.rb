module V1
  class SuperThemesController < BaseController
    # skip_before_action :authenticate_user!, only: [:create]
    before_action :set_super_theme, except: [:index, :test]
  
    # GET /
    def index
      super_themes = Model.config.super_theme.constant.all
      @pagy, @super_themes = pagy(super_themes)
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
        @super_theme = Model.config.super_theme.constant.find(params[:id])
      end
  end
end