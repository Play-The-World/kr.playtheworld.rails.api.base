module V1 # :nodoc:
  #
  # MakerTeams Controller
  # TODO Controller에 대한 설명
  #
  class MakerTeamsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_maker_team, except: [:index]

    def_param_group :maker_team do
      param :id, Integer, desc: "ID", required: true
      param :name, String, desc: "이름", required: true
      param :content, String, desc: "설명", required: true
      param :status, String, desc: "상태", required: true
    end
    crud_with :maker_team

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
        Model::MakerTeam
      end
  end
end
