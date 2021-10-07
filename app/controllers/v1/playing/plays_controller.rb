module V1::Playing
  class PlaysController < BaseController
    before_action :authenticate_user!
    before_action :set_play, except: [:set]

    # 현재 스테이지 목록
    def stage_lists
      if params[:after].to_i > 0
        data = @play.stage_lists.includes({
          translations: [],
          stages: [:audios, :videos, :images, :translations]
        }).offset(params[:after].to_i)
      else
        data = @play.stage_lists.includes({
          translations: [],
          stages: [:audios, :videos, :images, :translations]
        })
      end

      # if params[:stages]
      #   data = data.as_json(:play)
      # end

      render json: {
        data: data.as_json(:play)
      }
    end

    def detail
      # @play = Play.where(id: @play.id)
      #   .includes()
      #   .take
      data = {
        play: @play.as_json(:play)
      }
      if @super_theme.type == 'Model::SuperTheme::Crime'
        data[:super_theme] = @super_theme.as_json(:crime_show)
        data[:super_play] = @play.super_play.as_json(:crime)
      end

      render json: data
    end

    def set
      # TODO: 플레이가 있는지, 권한이 있는지.
      session[:play_id] = params[:play_id].to_i
      set_play
      set_data(@play)
      respond("성공")
    end

    def answer
      raise_error("종료된 플레이", 4000) unless @play.playing?
      raise_error("지니간 스테이지임", 4001) if @play.stage_lists.last.id != params[:stage_list_id].to_i

      correct, _branch = @play.submit_answer(params[:answer])

      if correct
        respond("정답 맞춤", 2000)
      else
        respond("틀림", 2001)
      end
    end

    def hint
      raise_error("종료된 플레이", 4000) unless @play.playing?
      raise_error("지니간 스테이지임", 4001) if @play.stage_lists.last.id != params[:stage_list_id].to_i
      
      hint, result, message = @play.use_hint(params[:hint_number].to_i)

      unless result
        raise_error(message, 4002)
      else
        set_data(hint)
        respond(message, 2000)
      end
    end

    def on_stage
      @play.on_stage(stage_index: params[:stage_index].to_i, stage_list_index: params[:stage_list_index].to_i)
      respond('성공', 2000)
    # rescue
    #   raise_error('스테이지 동기화에 실패하였습니다.')
    end

    def search
      # params[:search_type] = 'normal' | 'deep'
      # searchable_id, searchable_type
      searchable = nil
      case params[:searchable_type]
      when 'game_map'
        searchable = Model::GameMap.find_by(id: params[:searchable_id])
      when 'character'
        searchable = Model::Character.find_by(id: params[:searchable_id])
      end

      raise_error('단서 찾기에 실패하였습니다.') if searchable.nil?

      track = @play.tracks.last
      raise_error('잘못된 접근입니다.') if track.stage_list.type != 'Model::StageList::Search'

      clues = @play.search(params[:search_type], searchable)

      # if clues.size =< 0
      #   @play.notify('아무 단서도 찾지 못했습니다.')
      # else
      # end

      # set_data({})
      # respond
      # puts clues
      render json: {
        data: clues.as_json(:play)
      }
    end

    private
      def set_play
        if params[:play_id]
          @play = Model::Play::Base.find_by(id: params[:play_id])
          session[:play_id] = @play.id
        end
        puts 'params:', params[:play_id]

        @play ||= Model::Play::Base.find_by(id: session[:play_id])

        raise_error('플레이 데이터를 찾을 수 없습니다.') if @play.nil?
        raise_error('접근 권한이 없습니다.') if @play.user != current_user
        
        Model.current.play ||= @play

        @super_theme = @play.super_theme
      end
  end
end
