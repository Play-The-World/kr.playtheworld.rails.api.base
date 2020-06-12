module V1::Playing
  class ThemesController < BaseController
    before_action :set_theme, only: [:show, :play]
    before_action :authenticate_user!, only: [:play]

    Theme = Model::Theme

    def index
      # render json: {
      #   count: 1462,
      #   themes: [
      #     {
      #       type: "super_theme",
      #       id: "sadffwaefa",
      #       title: "김부장 프로젝트",
      #       summary: "꼰대력을 자랑하는 HR 1부 김부장이\n편지 한 장만 두고 사라졌다?!?",
      #       categories: [
      #         { title: "오프라인" }
      #       ],
      #       genres: [
      #         { title: "코믹" }
      #       ],
      #       locations: [
      #         { title: "세종문화회관" }
      #       ],
      #       images: [
      #         {
      #           type: "thumbnail",
      #           url: "https://t.playthe.world/t.png"
      #         }
      #       ]
      #     }
      #   ]
      # }

    end

    def show
      @theme = Theme::Base.first
      # json = @theme.serializer.new(@theme, include: [:super_theme]).serializable_hash
      json = ::Model::Serializer::Theme.new(@theme, include: [:super_theme]).serializable_hash
      # render json: @theme.as_json()
      render json: json
    end

    def show_test
      render json: {
        type: "super_theme",
        id: "sadffwaefa",
        title: "김부장 프로젝트",
        summary: "꼰대력을 자랑하는 HR 1부 김부장이\n편지 한 장만 두고 사라졌다?!?",
        categories: [
          { title: "오프라인" }
        ],
        genres: [
          { title: "코믹" }
        ],
        locations: [
          { title: "세종문화회관" }
        ],
        images: [
          {
            type: "thumbnail",
            url: "https://t.playthe.world/t.png"
          },
          {
            type: "poster",
            url: "https://t.playthe.world/t.png"
          }
        ],
        themes: [
          {
            type: "normal",
            theme_type: null,
            difficulty: 1,
            render_type: "swiper",
            content: "테마 내용",
            caution: "주의 사항",
            start_address: "시작 주소",
            start_position: "시작 장소 설명",
            price: 0,
            play_time: 60,
            data_size: 100,
            achievements_count: 6,
            endings_count: 2,
            plays_count: 10,
            preview_images: [
              {
                type: "background",
                order: 1,
                url: "https://t.playthe.world/t.png"
              },
              {
                type: "background",
                order: 2,
                url: "https://t.playthe.world/t.png"
              },
              {
                type: "background",
                order: 3,
                url: "https://t.playthe.world/t.png"
              }
            ],
            top_rank: {
              value: 100,
              user: {
                id: 1,
                nickname: "민"
              }
            }
          }
        ],
        current_user: {
          liked: false,
          play: {
            stage_index: 1,
            title: "김부장의 실종",
          }
        }
      }
    end

    def related_topics
      render json: {
        topics: [
          {
            type: "super_theme",
            title: "추천 테마",
            super_themes: [
              {
                type: "super_theme",
                id: "sadffwaefa",
                title: "김부장 프로젝트",
                summary: "꼰대력을 자랑하는 HR 1부 김부장이\n편지 한 장만 두고 사라졌다?!?",
                categories: [
                  { title: "오프라인" }
                ],
                genres: [
                  { title: "코믹" }
                ],
                locations: [
                  { title: "세종문화회관" }
                ],
                images: [
                  {
                    type: "thumbnail",
                    url: "https://t.playthe.world/t.png"
                  },
                  {
                    type: "poster",
                    url: "https://t.playthe.world/t.png"
                  }
                ]
              }
            ]
          }
        ]
      }
    end

    def play
      if play = @user.play_solo(theme: @theme)
        render json: {
            message: "플레이 시작",
            data: play.as_json,
            code: 2000
          }, status: :ok
      else
        render json: {
            message: "안됨",
            code: 4000
          }, status: :bad_request
      end
    # rescue
    #   render json: {}
    end

    private
      def user_params
        params.fetch(:query, {}).permit(:title, :categories, :genres)
      end

      def set_theme
        @theme = Model::Theme::Base.includes(:super_theme).find_by(fake_id: params[:id])
        @super_theme = @theme.super_theme rescue nil
      end
  end
end
