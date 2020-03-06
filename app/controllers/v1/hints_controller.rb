module V1 # :nodoc:
  #
  # Hints Controller
  # TODO Controller에 대한 설명
  #
  class HintsController < BaseController
    # skip_before_action :authenticate_user!, only: [:create]
    before_action :set_hint, except: [:index]

    # GET /
    def index
      @pagy, @hints = pagy(constant.all)
      render json: @hints
    end

    # POST /
    def create
      @hint = constant.new
      render json: @hint
    end

    # PATCH/PUT /:id
    def update
      render json: @hint
    end

    # GET /:id
    def show
      render json: @hint
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_hint
        @hint = constant.find(params[:id])
      end

      # Hint constant
      def constant
        Model::Hint
      end
  end
end
