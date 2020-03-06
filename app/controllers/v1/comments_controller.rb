module V1 # :nodoc:
  #
  # Comments Controller
  # TODO Controller에 대한 설명
  #
  class CommentsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_comment, except: [:index]

    # GET /
    def index
      @pagy, @comments = pagy(constant.all)
      render json: @comments
    end

    # POST /
    def create
      @comment = constant.new
      render json: @comment
    end

    # PATCH/PUT /:id
    def update
      render json: @comment
    end

    # GET /:id
    def show
      render json: @comment
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_comment
        @comment = constant.find(params[:id])
      end

      # Comment constant
      def constant
        Model.config.comment.constant
      end
  end
end
