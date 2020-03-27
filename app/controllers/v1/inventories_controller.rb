module V1 # :nodoc:
  #
  # Inventories Controller
  # TODO Controller에 대한 설명
  #
  class InventoriesController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_inventory, except: [:index]

    def_param_group :inventory do
      param :id, Integer, "ID", required: true
      param :space, Integer, "공간", default_value: 9
    end
    crud_with :inventory

    # GET /
    def index
      @pagy, @inventories = pagy(constant.all)
      render json: @inventories
    end

    # POST /
    def create
      @inventory = constant.new
      render json: @inventory
    end

    # PATCH/PUT /:id
    def update
      render json: @inventory
    end

    # GET /:id
    def show
      render json: @inventory
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_inventory
        @inventory = constant.find(params[:id])
      end

      # Inventory constant
      def constant
        Model::Inventory
      end
  end
end
