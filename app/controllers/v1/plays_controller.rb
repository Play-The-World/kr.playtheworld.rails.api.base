module V1 # :nodoc:
  #
  # Plays Controller
  # TODO Controller에 대한 설명
  #
  class PlaysController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_play, except: [:index]

    def_param_group :play do
      param :id, Integer, desc: "ID", required: true
      param :type, String, desc: "유형", required: true
      param :status, String, desc: "상태", required: true
      param :stage_list_index, Integer, desc: "스테이지 리스트 인덱스", required: true
      param :stage_index, Integer, desc: "스테이지 리스트의 스테이지 인덱스", required: true
      param :finished_at, DateTime, desc: "플레이가 끝난 시간", default_value: nil
    end
    crud_with :play

    # GET /
    def index
      @pagy, @plays = pagy(constant.all)
      render json: @plays
    end

    # POST /
    def create
      @play = constant.new
      render json: @play
    end

    # PATCH/PUT /:id
    def update
      render json: @play
    end

    # GET /:id
    def show
      render json: @play
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_play
        @play = constant.find(params[:id])
      end

      # Play constant
      def constant
        Model.config.play.constant
      end
  end
end
