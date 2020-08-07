module V1 # :nodoc:
  #
  # Events Controller
  # TODO Controller에 대한 설명
  #
  class EventsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_event, except: [:index]

    # def_param_group :event do
    #   param :id, Integer, desc: "ID", required: true
    #   param :type, String, desc: "유형", required: true
    #   param :value1, String, desc: "값1", required: true
    #   param :value2, String, desc: "값2", required: true
    #   param :value3, String, desc: "값3", required: true
    #   param :value4, String, desc: "값4", required: true
    #   param :repeatable, [true, false], desc: "반복 가능 여부", default_value: true
    # end
    # crud_with :event

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
