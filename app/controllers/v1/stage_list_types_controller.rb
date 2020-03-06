module V1 # :nodoc:
  #
  # StageListTypes Controller
  # TODO Controller에 대한 설명
  #
  class StageListTypesController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_stage_list_type, except: [:index]

    # GET /
    def index
      @pagy, @stage_list_types = pagy(constant.all)
      render json: @stage_list_types
    end

    # POST /
    def create
      @stage_list_type = constant.new
      render json: @stage_list_type
    end

    # PATCH/PUT /:id
    def update
      render json: @stage_list_type
    end

    # GET /:id
    def show
      render json: @stage_list_type
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_stage_list_type
        @stage_list_type = constant.find(params[:id])
      end

      # StageListType constant
      def constant
        Model::StageListType
      end
  end
end
