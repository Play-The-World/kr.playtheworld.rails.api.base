module V1 # :nodoc:
  #
  # Answers Controller
  # TODO Controller에 대한 설명
  #
  class AnswersController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_answer, except: [:index]

    # GET /
    def index
      @pagy, @answers = pagy(constant.all)
      render json: @answers
    end

    # POST /
    def create
      @answer = constant.new
      render json: @answer
    end

    # PATCH/PUT /:id
    def update
      render json: @answer
    end

    # GET /:id
    def show
      render json: @answer
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_answer
        @answer = constant.find(params[:id])
      end

      # Answer constant
      def constant
        Model.config.answer.constant
      end
  end
end
