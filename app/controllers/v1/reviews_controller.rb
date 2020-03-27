module V1 # :nodoc:
  #
  # Reviews Controller
  # TODO Controller에 대한 설명
  #
  class ReviewsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_review, except: [:index]

    def_param_group :review do
      param :id, Integer, desc: "ID", required: true
      param :type, String, desc: "유형", required: true
      param :status, String, desc: "상태", required: true
      param :title, String, desc: "제목", required: true
      param :content, String, desc: "내용", required: true
    end
    crud_with :review

    # GET /
    def index
      @pagy, @reviews = pagy(constant.all)
      render json: @reviews
    end

    # POST /
    def create
      @review = constant.new
      render json: @review
    end

    # PATCH/PUT /:id
    def update
      render json: @review
    end

    # GET /:id
    def show
      render json: @review
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_review
        @review = constant.find(params[:id])
      end

      # Review constant
      def constant
        Model.config.review.constant
      end
  end
end
