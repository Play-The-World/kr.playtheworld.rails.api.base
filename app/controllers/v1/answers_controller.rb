module V1 # :nodoc:
  #
  # Answers Controller
  # TODO Controller에 대한 설명
  #
  class AnswersController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_answer, except: [:index]

    def_param_group :answer do
      param     :id,                Integer,        desc: "정답 ID", required: true
      param     :type,              String,         desc: "정답 타입", required: true
      param     :value,             String,         desc: "정답값", required: true
      param     :ordered,           [true, false],  desc: "순서 상관 여부", default_value: false
      param     :case_sensitive,    [true, false],  desc: "대소문자 구분 여부", default_value: false
    end

    api! "정답 목록"
    param :page, Integer, desc: "페이지 번호", default_value: 1
    returns array_of: :answer
    # GET /
    def index
      @pagy, @answers = pagy(constant.all)
      render json: @answers
    end

    api! "정답 생성"
    param_group :answer
    returns :answer
    # POST /
    def create
      @answer = constant.new
      render json: @answer
    end

    api! "정답 수정"
    param_group :answer
    returns :answer
    # PATCH/PUT /:id
    def update
      render json: @answer
    end

    api! "정답 조회"
    param :id, Integer, desc: "정답 ID", required: true
    returns :answer
    # GET /:id
    def show
      render json: @answer
    end

    api! "정답 삭제"
    param :id, Integer, desc: "정답 ID", required: true
    returns :answer
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
