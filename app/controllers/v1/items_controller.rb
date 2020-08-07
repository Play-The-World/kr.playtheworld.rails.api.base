module V1 # :nodoc:
  #
  # Items Controller
  # TODO Controller에 대한 설명
  #
  class ItemsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_item, except: [:index]

    # def_param_group :item do
    #   param :id, Integer, desc: "ID", required: true
    #   param :title, String, desc: "이름", required: true
    #   param :content, String, desc: "내용", required: true
    #   param :level, Integer, desc: "등급", required: true
    # end
    # crud_with :item

    # GET /
    def index
      @pagy, @items = pagy(constant.all)
      render json: @items
    end

    # POST /
    def create
      @item = constant.new
      render json: @item
    end

    # PATCH/PUT /:id
    def update
      render json: @item
    end

    # GET /:id
    def show
      render json: @item
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_item
        @item = constant.find(params[:id])
      end

      # Item constant
      def constant
        Model::Item
      end
  end
end
