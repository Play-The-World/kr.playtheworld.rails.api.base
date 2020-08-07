module V1 # :nodoc:
  #
  # Stages Controller
  # TODO Controller에 대한 설명
  #
  class StagesController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_stage, except: [:index]

    # def_param_group :stage do
    #   param :id, Integer, desc: "ID", required: true
    #   param :type, String, desc: "유형", required: true
    #   param :order, Integer, desc: "순서", required: true
    #   param :content, String, desc: "내용", required: true
    # end
    # crud_with :stage

    # GET /
    def index
      @pagy, @stages = pagy(constant.all)
      render json: @stages
    end

    # POST /
    def create
      @stage = constant.new
      render json: @stage
    end

    # PATCH/PUT /:id
    def update
      render json: @stage
    end

    # GET /:id
    def show
      render json: @stage
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_stage
        @stage = constant.find(params[:id])
      end

      # Stage constant
      def constant
        Model.config.stage.constant
      end
  end
end
