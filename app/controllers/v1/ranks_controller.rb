module V1 # :nodoc:
  #
  # Ranks Controller
  # TODO Controller에 대한 설명
  #
  class RanksController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_rank, except: [:index]

    def_param_group :rank do
      param :id, Integer, desc: "ID", required: true
      param :value, String, desc: "점수", required: true
    end
    crud_with :rank

    # GET /
    def index
      @pagy, @ranks = pagy(constant.all)
      render json: @ranks
    end

    # POST /
    def create
      @rank = constant.new
      render json: @rank
    end

    # PATCH/PUT /:id
    def update
      render json: @rank
    end

    # GET /:id
    def show
      render json: @rank
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_rank
        @rank = constant.find(params[:id])
      end

      # Rank constant
      def constant
        Model::Rank
      end
  end
end
