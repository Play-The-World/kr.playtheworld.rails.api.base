module V1 # :nodoc:
  #
  # Branches Controller
  # TODO Controller에 대한 설명
  #
  class BranchesController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_branch, except: [:index]

    # def_param_group :branch do
    #   param     :id,                    Integer,        desc: "갈래 ID", required: true
    #   param     :type,                  String,         desc: "갈래 타입", required: true
    #   param     :target_stage_list_id,  String,         desc: "대상 스테이지 리스트 ID", default_value: nil
    # end
    # crud_with :branch

    # GET /
    def index
      @pagy, @branches = pagy(constant.all)
      render json: @branches
    end

    # POST /
    def create
      @branch = constant.new
      render json: @branch
    end

    # PATCH/PUT /:id
    def update
      render json: @branch
    end

    # GET /:id
    def show
      render json: @branch
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_branch
        @branch = constant.find(params[:id])
      end

      # Branch constant
      def constant
        # Model.config.branch.constant
        Model::Branch
      end
  end
end
