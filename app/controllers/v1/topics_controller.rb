module V1 # :nodoc:
  #
  # Topics Controller
  # TODO Controller에 대한 설명
  #
  class TopicsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_topic, except: [:index]

    # def_param_group :topic do
    #   param :id, Integer, desc: "ID", required: true
    #   param :type, String, desc: "유형", required: true
    #   param :title, String, desc: "제목", required: true
    # end
    # crud_with :topic

    # GET /
    def index
      @pagy, @topics = pagy(constant.all)
      render json: @topics
    end

    # POST /
    def create
      @topic = constant.new
      render json: @topic
    end

    # PATCH/PUT /:id
    def update
      render json: @topic
    end

    # GET /:id
    def show
      render json: @topic
    end

    # DELETE /:id
    def destroy
    end

    # GET /:id/super_themes
    def super_themes
      super_themes = @topic.super_themes
      render json: super_themes
    end

    private
      def set_topic
        @topic = constant.find(params[:id])
      end

      # Topic constant
      def constant
        Model.config.topic.constant
      end
  end
end
