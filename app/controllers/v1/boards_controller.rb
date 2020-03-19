module V1 # :nodoc:
  #
  # Boards Controller
  # TODO Controller에 대한 설명
  #
  class BoardsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_board, except: [:index]

    def_param_group :board do
      param     :id,                Integer,        desc: "게시판 ID", required: true
      param     :type,              String,         desc: "게시판 타입", required: true
      param     :status,            String,         desc: "게시판 상태", required: true
      property  :posts_count,       Integer,        desc: "게시글 수", default_value: 0
    end

    api! "게시판 목록"
    param :page, Integer, desc: "페이지 번호", default_value: 1
    returns array_of: :board
    # GET /
    def index
      @pagy, @boards = pagy(constant.all)
      render json: @boards
    end

    api! "게시판 생성"
    param_group :board
    returns :board
    # POST /
    def create
      @board = constant.new
      render json: @board
    end

    api! "게시판 수정"
    param_group :board
    returns :board
    # PATCH/PUT /:id
    def update
      render json: @board
    end

    api! "게시판 삭제"
    param :id, Integer, desc: "게시판 ID", required: true
    returns :board
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
