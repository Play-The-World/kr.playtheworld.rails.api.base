module V1 # :nodoc:
  #
  # Locations Controller
  # TODO Controller에 대한 설명
  #
  class LocationsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_location, except: [:index]

    # def_param_group :location do
    #   param :id, Integer, desc: "ID", required: true
    #   param :title, String, desc: "이름", required: true
    # end
    # crud_with :location

    # GET /
    def index
      @pagy, @locations = pagy(constant.all)
      render json: @locations
    end

    # POST /
    def create
      @location = constant.new
      render json: @location
    end

    # PATCH/PUT /:id
    def update
      render json: @location
    end

    # GET /:id
    def show
      render json: @location
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_location
        @location = constant.find(params[:id])
      end

      # Location constant
      def constant
        Model::Location
      end
  end
end
