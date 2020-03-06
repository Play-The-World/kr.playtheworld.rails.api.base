module V1 # :nodoc:
  #
  # Themes Controller
  # TODO Controller에 대한 설명
  #
  class ThemesController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_theme, except: [:index]

    # GET /
    def index
      @pagy, @themes = pagy(constant.all)
      render json: @themes
    end

    # POST /
    def create
      @theme = constant.new
      render json: @theme
    end

    # PATCH/PUT /:id
    def update
      render json: @theme
    end

    # GET /:id
    def show
      render json: @theme
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_theme
        @theme = constant.find(params[:id])
      end

      # Theme constant
      def constant
        Model.config.theme.constant
      end
  end
end
