module V1
  class SuperThemesController < BaseController
    # skip_before_action :authenticate_user!, only: [:create]
    before_action :set_super_theme, except: [:index, :test]
  
    # def_param_group :super_theme do
    #   param :id, Integer, desc: "ID", required: true
    #   param :type, String, desc: "유형", required: true
    #   param :status, String, desc: "상태", required: true
    #   param :title, String, desc: "제목", required: true
    #   param :content, String, desc: "내용", required: true
    #   param :summary, String, desc: "요약", required: true
    #   param :caution, String, desc: "주의사항", required: true
    #   param :price, Integer, desc: "가격", required: true
    #   param :play_time, Integer, desc: "플레이 시간", required: true
    #   param :data_size, Integer, desc: "예상 데이터", required: true
    # end
    # crud_with :super_theme

    # GET /
    def index
      data = constant.includes(
          locations: [:translations],
          genres: [:translations],
          categories: [:translations],
          # themes: [:translations],
        ).with_translations
        # .where()
      # data = constant.joins(
      #     locations: :translations,
      #     genres: :translations,
      #     categories: :translations,
      #     themes: :translations,
      #   ).with_translations
      # data = constant.includes(:classifications, :themes).with_translations
      @pagy, @super_themes = pagy(data)
      render json: {
          data: @super_themes.as_json(options),
          meta: pagy_metadata(@pagy)
        }
    end

    # GET /:id
    def show
      render json: @super_theme
    end

    def test
      render json: {}
    end

    private
      def set_super_theme
        @super_theme = constant.find(params[:id])
      end

      def constant
        Model.config.super_theme.constant
      end

      def options
        {
          fields: {
            super_theme: %i(status title summary content price data_size play_time caution genres locations categories)
          }
        }
      end
  end
end