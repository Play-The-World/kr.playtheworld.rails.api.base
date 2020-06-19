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

    def play
      if play = current_user.play_solo(theme: @theme)
        set_data(play.as_json)
        respond("플레이 시작")
      else
        raise_error("안됨")
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
        @super_theme = @theme&.super_theme
      end
  end
end
