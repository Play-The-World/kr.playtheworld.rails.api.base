module V1 # :nodoc:
  #
  # RankSeasons Controller
  # TODO Controller에 대한 설명
  #
  class RankSeasonsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_rank_season, except: [:index]

    def_param_group :rank_season do
      param :id, Integer, desc: "ID", required: true
      param :type, String, desc: "유형", required: true
      param :status, String, desc: "상태", required: true
      param :title, String, desc: "제목", required: true
      param :content, String, desc: "내용", required: true
      property :start_date, DateTime, desc: "시작 날짜"
      property :end_date, DateTime, desc: "끝 날짜"
      property :ranks_count, Integer, desc: "랭크 기록 개수"
    end
    crud_with :rank_season

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
