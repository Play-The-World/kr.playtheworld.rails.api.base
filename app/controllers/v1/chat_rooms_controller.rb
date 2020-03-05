module V1 # :nodoc:
  #
  # ChatRooms Controller
  # TODO Controller에 대한 설명
  #
  class ChatRoomsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_chat_room, except: [:index]

    # GET /
    def index
      @pagy, @chat_rooms = pagy(constant.all)
      render json: @chat_rooms
    end

    # POST /
    def create
      @chat_room = constant.new
      render json: @chat_room
    end

    # PATCH/PUT /:id
    def update
      render json: @chat_room
    end

    # GET /:id
    def show
      render json: @chat_room
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_chat_room
        @chat_room = constant.find(params[:id])
      end

      # ChatRoom constant
      def constant
        Model.config.chat_room.constant
      end
  end
end
