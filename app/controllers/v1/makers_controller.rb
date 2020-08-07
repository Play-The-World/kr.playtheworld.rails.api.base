module V1 # :nodoc:
  #
  # Makers Controller
  # TODO Controller에 대한 설명
  #
  class MakersController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_maker, except: [:index]

    # def_param_group :maker do
    #   param :id, Integer, desc: "ID", required: true
    #   param :name, String, desc: "이름", required: true
    #   param :content, String, desc: "설명", required: true
    #   param :status, String, desc: "상태", required: true
    # end
    # crud_with :maker

    # GET /
    def index
      @pagy, @makers = pagy(constant.all)
      render json: @makers
    end

    # POST /
    def create
      @maker = constant.new
      render json: @maker
    end

    # PATCH/PUT /:id
    def update
      render json: @maker
    end

    # GET /:id
    def show
      render json: @maker
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_maker
        @maker = constant.find(params[:id])
      end

      # Maker constant
      def constant
        Model::Maker
      end
  end
end
