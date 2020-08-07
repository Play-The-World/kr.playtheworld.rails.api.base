module V1 # :nodoc:
  #
  # Tokens Controller
  # TODO Controller에 대한 설명
  #
  class TokensController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_token, except: [:index]

    # def_param_group :token do
    #   param :id, Integer, desc: "ID", required: true
    #   param :type, String, desc: "유형", required: true
    #   param :value, String, desc: "값", required: true
    #   param :expired_at, DateTime, desc: "만료 일자", required: true
    # end
    # crud_with :token

    # GET /
    def index
      @pagy, @tokens = pagy(constant.all)
      render json: @tokens
    end

    # POST /
    def create
      @token = constant.new
      render json: @token
    end

    # PATCH/PUT /:id
    def update
      render json: @token
    end

    # GET /:id
    def show
      render json: @token
    end

    # DELETE /:id
    def destroy
    end

    private
      def set_token
        @token = constant.find(params[:id])
      end

      # Token constant
      def constant
        Model.config.token.constant
      end
  end
end
