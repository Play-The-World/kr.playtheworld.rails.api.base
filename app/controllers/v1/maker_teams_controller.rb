module V1 # :nodoc:
  #
  # MakerTeams Controller
  # TODO Controller에 대한 설명
  #
  class MakerTeamsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_maker_team, except: [:index]

    # GET /
    def index
      @pagy, @maker_teams = pagy(constant.all)
      render json: @maker_teams
    end

    # POST /
    def create
      @maker_team = constant.new
      render json: @maker_team
    end

    # PATCH/PUT /:id
    def update
      render json: @maker_team
    end

    # GET /:id
    def show
      render json: @maker_team
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_maker_team
        @maker_team = constant.find(params[:id])
      end

      # MakerTeam constant
      def constant
        Model.config.maker_team.constant
      end
  end
end
