module V1 # :nodoc:
  #
  # Teams Controller
  # TODO Controller에 대한 설명
  #
  class TeamsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_team, except: [:index]

    # GET /
    def index
      @pagy, @teams = pagy(constant.all)
      render json: @teams
    end

    # POST /
    def create
      @team = constant.new
      render json: @team
    end

    # PATCH/PUT /:id
    def update
      render json: @team
    end

    # GET /:id
    def show
      render json: @team
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_team
        @team = constant.find(params[:id])
      end

      # Team constant
      def constant
        Model::Team
      end
  end
end
