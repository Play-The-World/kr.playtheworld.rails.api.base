module V1::Making
  class MainController < BaseController
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
          raise_error("잘못된 RenderType", 400)
        end

        c = Model::Category.find_by(type: params[:category]&.downcase)
        raise_error("잘못된 카테고리", 404) if c.nil?
        st = Model::SuperTheme::Normal.create!
        st.categories << c
        t = st.create_theme(render_type: rt)
        t.theme_data.create!

        current_user.maker.super_themes << st
        current_user.maker.themes << t

        set_data(t.as_json(:making))
        respond("생성 성공", 201)
      end
    end
  end
end
