class ApiControllerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)
  def create_condition_file
    create_file(
      "app/controllers/v1/#{file_name.pluralize}_controller.rb", 
      <<-FILE
module V1 # :nodoc:
  #
  # #{file_name.pluralize.camelize} Controller
  # TODO Controller에 대한 설명
  #
  class #{file_name.pluralize.camelize}Controller < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_#{file_name}, except: [:index]

    # GET /
    def index
      @pagy, @#{file_name.pluralize} = pagy(constant.all)
      render json: @#{file_name.pluralize}
    end

    # POST /
    def create
      @#{file_name} = constant.new
      render json: @#{file_name}
    end

    # PATCH/PUT /:id
    def update
      render json: @#{file_name}
    end

    # GET /:id
    def show
      render json: @#{file_name}
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_#{file_name}
        @#{file_name} = constant.find(params[:id])
      end

      # #{file_name.camelize} constant
      def constant
        Model.config.#{file_name}.constant
      end
  end
end
      FILE
    )
  end
end