module V1 # :nodoc:
  #
  # Settings Controller
  # TODO Controller에 대한 설명
  #
  class SettingsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_setting, except: [:index]

    # GET /
    def index
      @pagy, @settings = pagy(constant.all)
      render json: @settings
    end

    # POST /
    def create
      @setting = constant.new
      render json: @setting
    end

    # PATCH/PUT /:id
    def update
      render json: @setting
    end

    # GET /:id
    def show
      render json: @setting
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_setting
        @setting = constant.find(params[:id])
      end

      # Setting constant
      def constant
        Model::Setting
      end
  end
end
