module V1 # :nodoc:
  #
  # Categories Controller
  # TODO Controller에 대한 설명
  #
  class CategoriesController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_category, except: [:index]

    def_param_group :category do
      param     :id,                Integer,        desc: "카테고리 ID", required: true
      param     :title,             String,         desc: "카테고리 이름", required: true
    end

    api! "카테고리 목록"
    param :page, Integer, desc: "페이지 번호", default_value: 1
    returns array_of: :category
    # GET /
    def index
      @pagy, @categories = pagy(constant.all)
      render json: @categories
    end

    api! "카테고리 생성"
    param_group :category
    returns :category
    # POST /
    def create
      @category = constant.new
      render json: @category
    end

    api! "카테고리 수정"
    param_group :category
    returns :category
    # PATCH/PUT /:id
    def update
      render json: @category
    end

    api! "카테고리 조회"
    param :id, Integer, desc: "카테고리 ID", required: true
    returns :category
    # GET /:id
    def show
      render json: @category
    end

    api! "카테고리 삭제"
    param :id, Integer, desc: "카테고리 ID", required: true
    returns :category
    # DELETE /:id
    def destroy
    end

    private
      def set_category
        @category = constant.find(params[:id])
      end

      # Category constant
      def constant
        Model::Category
      end
  end
end
