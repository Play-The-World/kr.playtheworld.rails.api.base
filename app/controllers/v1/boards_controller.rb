module V1 # :nodoc:
  #
  # Boards Controller
  # TODO Controller에 대한 설명
  #
  class BoardsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_board, except: [:index]

    # GET /
    def index
      @pagy, @boards = pagy(constant.all)
      render json: @boards
    end

    # POST /
    def create
      @board = constant.new
      render json: @board
    end

    # PATCH/PUT /:id
    def update
      render json: @board
    end

    # GET /:id
    def show
      render json: @board
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_board
        @board = constant.find(params[:id])
      end

      # Board constant
      def constant
        Model.config.board.constant
      end
  end
end
