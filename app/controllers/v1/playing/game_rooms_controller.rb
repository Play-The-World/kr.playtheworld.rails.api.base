module V1::Playing
  class GameRoomsController < BaseController
    before_action :set_super_theme
    before_action :set_game_room, except: [:index, :create]
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
      if @game_room.entries.find { |e| e.user == current_user }.nil?
        raise_error("참여하지 않은 대기실입니다.")
      end
      
      set_data({
        game_room: @game_room.as_json(:crime),
        # super_theme: @super_theme.as_json(:crime_show)
      })
      respond
      # render json: {
      #   data: @game_room.as_json(:play)
      # }
    end

    # POST /
    def create
      @theme ||= @super_theme.themes.includes({
        theme_data: {
          character_in_themes: {},
        },
      }).take
      @game_room = @super_theme.game_rooms.create!({
        type: params[:type] || 'default',
        theme_data: @theme.current_theme_data,
        title: params[:title],
        content: params[:content],
        password: params[:password],
        max_user_count: @theme.play_user_count, # @super_theme.play_user_counts[1]
      })
      @game_room.entries.create!(
        user: current_user,
        current: :pick
      )
      @game_room.character_in_game_rooms.create!(
        @theme.characters.map do |c|
          {
            character: c,
          }
        end
      )

      data = @game_room.as_json(:crime)
      set_data({ game_room: data })
      pusher(
        name: "SuperTheme#{@super_theme.id}Rooms",
        event: "game_room",
        params: data
      )
      respond
    end

    # POST /:id/entry
    def entry
      # params[:password]
      @entry = @game_room.entries.find { |e| e.user == current_user }
      if @entry
        respond
        return
      end

      if @game_room.type == :private and @game_room.password != params[:password]
        raise_error("비밀번호가 틀렸습니다.", 4000)
      end

      if @game_room.entries.size >= @game_room.max_user_count
        raise_error("방이 꽉 찼습니다.", 4001)
      end

      @game_room.entries.create!(user: current_user, current: :pick)
      pusher(
        name: "SuperTheme#{@super_theme.id}Rooms",
        event: "game_room",
        params: @game_room.as_json(:crime)
      )
      respond
    end

    # DELETE /:id/exit
    def exit
      @entry = @game_room.entries.find { |e| e.user == current_user }
      unless @entry
        raise_error("참가하지 않은 방입니다.")
      end

      if @game_room.status == :started
        raise_error("게임을 시작한 방은 나갈 수 없습니다.")
      end

      # 1명인 경우 방 삭제
      if @game_room.entries.size == 1
        id = @game_room.id
        @game_room.destroy
        pusher(
          name: "SuperTheme#{@super_theme.id}Rooms",
          event: "game_room_delete",
          params: { id: id }
        )
      else
        cig = @game_room.character_in_game_rooms.find { |c| c.user == current_user }
        if cig
          cig.update!(user_id: nil)
        end
        @entry.destroy
        pusher(
          name: "SuperTheme#{@super_theme.id}Rooms",
          event: "game_room",
          params: @game_room.as_json(:crime)
        )
      end
      respond
    end

    # POST /:id/select_character
    def select_character
      if @game_room.character_in_game_rooms.find_by(user: current_user)
        raise_error("이미 선택하셨습니다.", 4002)
      end

      # @character = Model::Character::Base.find_by(id: params[:character_id])
      @cgr = @game_room.character_in_game_rooms.find_by(
        character_id: params[:character_id]
      )

      raise_error("존재하지 않는 캐릭터입니다.", 4000, 404) if @cgr.nil?

      if !@cgr.user_id.nil?
        if @cgr.user_id != current_user.id
          raise_error("이미 선택된 용의자입니다.", 4001)
        end
      else
        @cgr.update!(user: current_user)
      end
      pusher(
        name: "GameRoom#{@game_room.id}",
        event: "character_in_game_room",
        params: @cgr.as_json(:base)
      )
      respond
    end

    # POST /:id/ready
    def ready
      if @game_room.character_in_game_rooms.find_by(user: current_user).nil?
        raise_error("캐릭터가 선택되지 않았습니다.", 4000)
      end

      entry = @game_room.entries.find { |e| e.user == current_user }

      if entry.nil?
        raise_error("참가하지 않은 방입니다.", 4001)
      end

      entry.update!(ready: !entry.ready)
      pusher(
        name: "GameRoom#{@game_room.id}",
        event: "entry",
        params: entry.as_json(:base)
      )

      if @game_room.entries.select { |e| e.ready }.size >= 1 # >= @game_room.max_user_count
        start_play
      end

      respond
    end

    private
      def start_play
        return if @game_room.status == :started

        if @game_room.team.nil?
          @team = Model::Team::Default.create!(purpose: :one_time)
          @game_room.update!(team: @team)
          @team.users << @game_room.users
        end

        @team ||= @game_room.team

        plays = @team.start_play({ theme_data: @game_room.theme_data, game_room: @game_room })
        # @game_room.update!(super_play: plays[0].super_play, status: :started)

        if plays
          pusher(
            name: "GameRoom#{@game_room.id}",
            event: "start_play",
            params: plays.map do |a|
              {
                play_id: a.id.to_s,
                user_id: a.user_id.to_s
              }
            end
          )
        end
      end

      def set_super_theme
        constant = Model.config.super_theme.constant
        @super_theme = constant.where(fake_id: params[:super_theme_id])
          .or(constant.where(id: params[:super_theme_id]))
          .includes({
            themes: {},
            images: {},
            characters: {
              images: {}
            }
          })
          .take
        raise_error("존재하지 않는 테마입니다.", nil, 404) if @super_theme.nil?
      end

      def set_game_room
        @game_room = constant.find_by(id: params[:id])
        raise_error("존재하지 않는 방입니다.", nil, 404) if @game_room.nil?
        Model.current.game_room ||= @game_room
      end

      def constant
        Model::GameRoom
      end
  end
end
