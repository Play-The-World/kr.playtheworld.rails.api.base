module V1 # :nodoc:
  #
  # Events Controller
  # TODO Controller에 대한 설명
  #
  class EventsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_event, except: [:index]

    # GET /
    def index
      @pagy, @events = pagy(constant.all)
      render json: @events
    end

    # POST /
    def create
      @event = constant.new
      render json: @event
    end

    # PATCH/PUT /:id
    def update
      render json: @event
    end

    # GET /:id
    def show
      render json: @event
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_event
        @event = constant.find(params[:id])
      end

      # Event constant
      def constant
        Model.config.event.constant
      end
  end
end
