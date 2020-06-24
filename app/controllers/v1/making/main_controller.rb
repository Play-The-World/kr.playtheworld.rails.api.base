module V1::Making
  class MainController < BaseController
    def create_theme
      # params[:play_type]
      # params[:render_type]
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

        set_data(t.as_json(:making))
        respond("성공")
      end
    end
  end
end
