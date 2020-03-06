module V1 # :nodoc:
  #
  # ChatMessages Controller
  # TODO Controller에 대한 설명
  #
  class ChatMessagesController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_chat_message, except: [:index]

    # GET /
    def index
      @pagy, @chat_messages = pagy(constant.all)
      render json: @chat_messages
    end

    # POST /
    def create
      @chat_message = constant.new
      render json: @chat_message
    end

    # PATCH/PUT /:id
    def update
      render json: @chat_message
    end

    # GET /:id
    def show
      render json: @chat_message
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_chat_message
        @chat_message = constant.find(params[:id])
      end

      # ChatMessage constant
      def constant
        Model.config.chat_message.constant
      end
  end
end
