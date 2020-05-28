module V1::Playing
  class MainController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    
    def topics
      data = Model::Repository::Topic.new.current_topics_with_super_themes
      render json: serializer.topics(data)
    end

    private
      def serializer
        Serializer::Main
      end
  end
end
