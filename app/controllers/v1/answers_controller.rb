module V1 # :nodoc:
  #
  # Answers Controller
  # TODO Controller에 대한 설명
  #
  class AnswersController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_answer, except: [:index]

    # def_param_group :answer do
    #   param     :id,                Integer,        desc: "정답 ID", required: true
    #   param     :type,              String,         desc: "정답 타입", required: true
    #   param     :value,             String,         desc: "정답값", required: true
    #   param     :ordered,           [true, false],  desc: "순서 상관 여부", default_value: false
    #   param     :case_sensitive,    [true, false],  desc: "대소문자 구분 여부", default_value: false
    # end
    # crud_with :answer

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
