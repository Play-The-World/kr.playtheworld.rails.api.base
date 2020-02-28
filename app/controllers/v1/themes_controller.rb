module V1
  class ThemesController < BaseController
    # skip_before_action :authenticate_user!, only: [:create]
    before_action :set_theme, except: [:index, :test]
  
    # GET /
    def index
      themes = Model.config.theme.constant.all
      render json: themes
    end

    # GET /:id
    def show
      render json: @theme
    end

    def test
      render json: {}
    end

    private
      def set_theme
        @theme = Model.config.theme.constant.find(params[:id])
      end
  end
end