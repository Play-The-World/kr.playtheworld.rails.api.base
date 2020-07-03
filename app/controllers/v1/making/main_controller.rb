module V1::Making
  class MainController < BaseController
    before_action :authenticate_user!#, only: [:create_]

    def create_theme
      current_user.create_maker!(name: current_user.nickname) if current_user.maker.nil?

      ActiveRecord::Base.transaction do
        case params[:render_type]
        when "swiper"
          rt = Model::RenderType::Swiper.new
        when "scroll"
          rt = Model::RenderType::Scroll.new
        when "text"
          rt = Model::RenderType::Text.new
        else
          raise_error("잘못된 RenderType", 4000)
        end

        case params[:category]
        when "online"
          c = Model::Category.find_by(title: "온라인")
        when "offline"
          c = Model::Category.find_by(title: "오프라인")
        else
          raise_error("잘못된 카테고리", 4001)
        end

        st = Model::SuperTheme::Normal.create!
        st.categories << c unless c.nil?
        t = st.create_theme(render_type: rt)
        td = t.theme_data.create!

        current_user.maker.super_themes << st
        current_user.maker.themes << t

        set_data(t.as_json(:making))
        respond("성공")
      end
    end
  end
end
