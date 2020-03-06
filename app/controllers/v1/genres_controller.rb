module V1 # :nodoc:
  #
  # Genres Controller
  # TODO Controller에 대한 설명
  #
  class GenresController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_genre, except: [:index]

    # GET /
    def index
      @pagy, @genres = pagy(constant.all)
      render json: @genres
    end

    # POST /
    def create
      @genre = constant.new
      render json: @genre
    end

    # PATCH/PUT /:id
    def update
      render json: @genre
    end

    # GET /:id
    def show
      render json: @genre
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_genre
        @genre = constant.find(params[:id])
      end

      # Genre constant
      def constant
        Model::Genre
      end
  end
end
