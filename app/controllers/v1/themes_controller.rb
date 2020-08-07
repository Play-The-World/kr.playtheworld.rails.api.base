module V1 # :nodoc:
  #
  # Themes Controller
  # TODO Controller에 대한 설명
  #
  class ThemesController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :set_theme, except: [:index]

    # def_param_group :theme do
    #   param :id, Integer, desc: "ID", required: true
    #   param :type, String, desc: "유형", required: true
    #   param :theme_type, String, desc: "테마 유형", required: true
    #   param :status, String, desc: "상태", required: true
    #   param :start_stage_list_number, Integer, desc: "시작 스테이지 리스트 번호", required: true
    #   param :difficulty, Integer, desc: "난이도", required: true
    #   param :render_type, String, desc: "랜더 방식", required: true
    #   param :start_address, String, desc: "시작 주소", default_value: ""
    #   param :start_position, String, desc: "시작 위치", default_value: ""
    #   param :content, String, desc: "내용", required: true
    #   param :caution, String, desc: "주의사항", required: true
    #   param :price, Integer, desc: "가격", required: true
    #   param :play_time, Integer, desc: "플레이 시간", required: true
    #   param :data_size, Integer, desc: "예상 데이터", required: true
    # end
    # crud_with :theme

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
