module V1
  class MainController < BaseController
    # skip_before_action :authenticate_user!, only: [:create]
  
    # GET /
    def index
      topics = Application.current.topics
      render json: {
        topics: Model::Serializer::Topic.new(topics).serialized_json
      }
    end

    def test
      render json: {"data":[{"id":"1","type":"topic","attributes":{"title":"오늘의 테마"},"relationships":{"super_themes":{"data":[{"id":"1","type":"super_theme"},{"id":"1","type":"super_theme"}]}}}]}
    end
  end
end