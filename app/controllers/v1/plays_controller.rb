module V1 # :nodoc:
  #
  # Plays Controller
  # TODO Controller에 대한 설명
  #
  class PlaysController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_play, except: [:index]

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
