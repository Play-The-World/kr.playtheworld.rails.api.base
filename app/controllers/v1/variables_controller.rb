module V1 # :nodoc:
  #
  # Variables Controller
  # TODO Controller에 대한 설명
  #
  class VariablesController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_variable, except: [:index]

    # GET /
    def index
      @pagy, @variables = pagy(constant.all)
      render json: @variables
    end

    # POST /
    def create
      @variable = constant.new
      render json: @variable
    end

    # PATCH/PUT /:id
    def update
      render json: @variable
    end

    # GET /:id
    def show
      render json: @variable
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_variable
        @variable = constant.find(params[:id])
      end

      # Variable constant
      def constant
        Model::Variable
      end
  end
end
