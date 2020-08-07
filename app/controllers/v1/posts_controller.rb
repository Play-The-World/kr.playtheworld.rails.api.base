module V1 # :nodoc:
  #
  # Posts Controller
  # TODO Controller에 대한 설명
  #
  class PostsController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_post, except: [:index]

    # def_param_group :post do
    #   param :id, Integer, desc: "ID", required: true
    #   param :type, String, desc: "유형", required: true
    #   param :status, String, desc: "상태", required: true
    #   param :title, String, desc: "제목", required: true
    #   param :content, String, desc: "내용", required: true
    # end
    # crud_with :post

    # GET /
    def index
      @pagy, @posts = pagy(constant.all)
      render json: @posts
    end

    # POST /
    def create
      @post = constant.new
      render json: @post
    end

    # PATCH/PUT /:id
    def update
      render json: @post
    end

    # GET /:id
    def show
      render json: @post
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_post
        @post = constant.find(params[:id])
      end

      # Post constant
      def constant
        Model.config.post.constant
      end
  end
end
