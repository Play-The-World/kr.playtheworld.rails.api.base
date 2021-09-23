module V1::Playing
  class ChatRoomsController < BaseController
    # before_action :set_super_theme
    before_action :set_chat_room, except: [:index, :create]
    before_action :authenticate_user!, except: [:index]

    # GET /
    def index
      set_data({
        game_rooms: @super_theme.game_rooms.as_json(:play)
      })
      respond
    end

    # GET /:id
    def show
      set_data({
        chat_room: @chat_room.as_json(:show),
      })
      respond
    end

    private
      def set_chat_room
        @chat_room = constant.find_by(id: params[:id])
        raise_error("존재하지 않는 방입니다.", 404) if @chat_room.nil?
      end

      def constant
        Model::ChatRoom
      end
  end
end
