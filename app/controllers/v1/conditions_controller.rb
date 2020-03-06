module V1 # :nodoc:
  #
  # Conditions Controller
  # TODO Controller에 대한 설명
  #
  class ConditionsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_condition, except: [:index]

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
