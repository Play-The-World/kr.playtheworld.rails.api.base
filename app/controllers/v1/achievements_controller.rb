module V1 # :nodoc:
  #
  # Achievements Controller
  # TODO Controller에 대한 설명
  #
  class AchievementsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_achievement, except: [:index]

    def_param_group :achievement do
      property  :id,                Integer,  desc: "업적 ID"
      param     :title,             String,   desc: "업적 이름", require: true
      param     :content,           String,   desc: "업적 설명", require: true
      param     :condition_content, String,   desc: "업적 획득 조건 설명", require: true
      param     :level,             Integer,  desc: "업적 등급", require: true
      param     :stackable,         [true, false],  desc: "동일 업적 중복 획득 가능 여부", require: true
    end

    api!
    param :page, Integer, desc: "페이지 번호"
    returns array_of: :achievement
    # GET /
    def index
      @pagy, @achievements = pagy(constant.all)
      render json: @achievements
    end

    api!
    param_group :achievement
    returns :achievement
    # POST /
    def create
      @achievement = constant.new
      render json: @achievement
    end

    api!
    param_group :achievement
    returns :achievement
    # PATCH/PUT /:id
    def update
      render json: @achievement
    end

    api!
    param_group :achievement
    returns :achievement
    # GET /:id
    def show
      render json: @achievement
    end

    api!
    # returns :achievement
    # DELETE /:id
    def destroy
    end

    private
      def set_achievement
        @achievement = constant.find(params[:id])
      end

      # Achievement constant
      def constant
        # Model.config.achievement.constant
        Model::Achievement
      end
  end
end
