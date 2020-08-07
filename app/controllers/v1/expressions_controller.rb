module V1 # :nodoc:
  #
  # Expressions Controller
  # TODO Controller에 대한 설명
  #
  class ExpressionsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_expression, except: [:index]

    # def_param_group :expression do
    #   param :id, Integer, desc: "ID", required: true
    #   param :type, String, desc: "유형", required: true
    # end
    # crud_with :expression

    # GET /
    def index
      @pagy, @expressions = pagy(constant.all)
      render json: @expressions
    end

    # POST /
    def create
      @expression = constant.new
      render json: @expression
    end

    # PATCH/PUT /:id
    def update
      render json: @expression
    end

    # GET /:id
    def show
      render json: @expression
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_expression
        @expression = constant.find(params[:id])
      end

      # Expression constant
      def constant
        Model.config.expression.constant
      end
  end
end
