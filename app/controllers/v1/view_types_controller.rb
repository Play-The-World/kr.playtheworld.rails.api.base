module V1 # :nodoc:
  #
  # ViewTypes Controller
  # TODO Controller에 대한 설명
  #
  class ViewTypesController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_view_type, except: [:index]

    # GET /
    def index
      @pagy, @view_types = pagy(constant.all)
      render json: @view_types
    end

    # POST /
    def create
      @view_type = constant.new
      render json: @view_type
    end

    # PATCH/PUT /:id
    def update
      render json: @view_type
    end

    # GET /:id
    def show
      render json: @view_type
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_view_type
        @view_type = constant.find(params[:id])
      end

      # ViewType constant
      def constant
        Model::ViewType
      end
  end
end
