module V1 # :nodoc:
  #
  # SuperPlays Controller
  # TODO Controller에 대한 설명
  #
  class SuperPlaysController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_super_play, except: [:index]

    # GET /
    def index
      @pagy, @super_plays = pagy(constant.all)
      render json: @super_plays
    end

    # POST /
    def create
      @super_play = constant.new
      render json: @super_play
    end

    # PATCH/PUT /:id
    def update
      render json: @super_play
    end

    # GET /:id
    def show
      render json: @super_play
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_super_play
        @super_play = constant.find(params[:id])
      end

      # SuperPlay constant
      def constant
        Model.config.super_play.constant
      end
  end
end
