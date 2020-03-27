module V1 # :nodoc:
  #
  # StageLists Controller
  # TODO Controller에 대한 설명
  #
  class StageListsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_stage_list, except: [:index]

    def_param_group :stage_list do
      param :id, Integer, desc: "ID", required: true
      param :stage_list_number, Integer, desc: "번호", required: true
      param :title, String, desc: "제목", required: true
    end
    crud_with :stage_list

    # GET /
    def index
      @pagy, @stage_lists = pagy(constant.all)
      render json: @stage_lists
    end

    # POST /
    def create
      @stage_list = constant.new
      render json: @stage_list
    end

    # PATCH/PUT /:id
    def update
      render json: @stage_list
    end

    # GET /:id
    def show
      render json: @stage_list
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_stage_list
        @stage_list = constant.find(params[:id])
      end

      # StageList constant
      def constant
        Model::StageList
      end
  end
end
