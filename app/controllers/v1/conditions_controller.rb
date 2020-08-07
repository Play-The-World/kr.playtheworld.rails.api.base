module V1 # :nodoc:
  #
  # Conditions Controller
  # TODO Controller에 대한 설명
  #
  class ConditionsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_condition, except: [:index]

    # def_param_group :condition do
    #   param :id, Integer, desc: "ID", required: true
    #   param :type, String, desc: "유형", required: true
    #   param :value1, String, desc: "값1", required: true
    #   param :value2, String, desc: "값2", required: true
    # end
    # crud_with :condition

    # GET /
    def index
      @pagy, @conditions = pagy(constant.all)
      render json: @conditions
    end

    # POST /
    def create
      @condition = constant.new
      render json: @condition
    end

    # PATCH/PUT /:id
    def update
      render json: @condition
    end

    # GET /:id
    def show
      render json: @condition
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_condition
        @condition = constant.find(params[:id])
      end

      # Condition constant
      def constant
        Model.config.condition.constant
      end
  end
end
