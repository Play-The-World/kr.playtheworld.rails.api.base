module V1
  class SuperThemesController < BaseController
    # skip_before_action :authenticate_user!, only: [:create]
    before_action :set_topic, except: [:index, :test]
  
    # GET /
    def index
      super_themes = Model.config.super_theme.constant.all
      render json: super_themes
    end

    # GET /:id
    def show
      render json: @super_theme
    end

    def test
      render json: {}
    end

    private
      def set_topic
        @super_theme = Model.config.super_theme.constant.find(params[:id])
      end
  end
end