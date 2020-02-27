module V1
  class TopicsController < BaseController
    # skip_before_action :authenticate_user!, only: [:create]
    before_action :set_topic, except: [:index, :test]
  
    # GET /
    def index
      topics = Model::Application.current.setting.topics rescue []
      render json: topics
    end

    # GET /:id
    def show
      render json: @topic
    end

    # GET /:id/super_themes
    def super_themes
      super_themes = @topic.super_themes
      super_themes = [Model::SuperTheme::Base.first, Model::SuperTheme::Base.first]
      render json: super_themes
    end

    def test
      render json: {}
    end

    private
      def set_topic
        @topic = Model.config.topic.constant.find(params[:id])
      end
  end
end