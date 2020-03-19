module V1 # :nodoc:
  #
  # ChatMessages Controller
  # TODO Controller에 대한 설명
  #
  class ChatMessagesController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_chat_message, except: [:index]

    def_param_group :chat_message do
      param     :id,                Integer,        desc: "채팅 메시지 ID", required: true
      param     :content,           String,         desc: "채팅 메시지 내용", required: true
    end

    api! "채팅 메시지 목록"
    param :page, Integer, desc: "페이지 번호", default_value: 1
    returns array_of: :chat_message
    # GET /
    def index
      @pagy, @chat_messages = pagy(constant.all)
      render json: @chat_messages
    end

    api! "채팅 메시지 생성"
    param_group :chat_message
    returns :chat_message
    # POST /
    def create
      @chat_message = constant.new
      render json: @chat_message
    end

    api! "채팅 메시지 수정"
    param_group :chat_message
    returns :chat_message
    # PATCH/PUT /:id
    def update
      render json: @chat_message
    end

    api! "채팅 메시지 조회"
    param :id, Integer, desc: "채팅 메시지 ID", required: true
    returns :chat_message
    # GET /:id
    def show
      render json: @chat_message
    end

    api! "채팅 메시지 삭제"
    param :id, Integer, desc: "채팅 메시지 ID", required: true
    returns :chat_message
    # DELETE /:id
    def destroy
    end

    private
      def set_chat_message
        @chat_message = constant.find(params[:id])
      end

      # ChatMessage constant
      def constant
        Model::ChatMessage
      end
  end
end
