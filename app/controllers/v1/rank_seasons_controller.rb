module V1 # :nodoc:
  #
  # RankSeasons Controller
  # TODO Controller에 대한 설명
  #
  class RankSeasonsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_rank_season, except: [:index]

    # GET /
    def index
      @pagy, @rank_seasons = pagy(constant.all)
      render json: @rank_seasons
    end

    # POST /
    def create
      @rank_season = constant.new
      render json: @rank_season
    end

    # PATCH/PUT /:id
    def update
      render json: @rank_season
    end

    # GET /:id
    def show
      render json: @rank_season
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_rank_season
        @rank_season = constant.find(params[:id])
      end

      # RankSeason constant
      def constant
        Model::RankSeason
      end
  end
end
