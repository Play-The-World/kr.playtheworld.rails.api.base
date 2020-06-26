module V1::Making
  class ThemesController < BaseController
    # skip_before_action :authenticate_user!, only: [:create]
    before_action :set_theme, except: [:index]
  
    # GET /
    def index
      data = constant.includes(
          translations: [],
          images: [],
          super_theme: [:translations]
        )
      @pagy, @themes = pagy(data)
      render json: {
          data: @themes.as_json(:images),
          meta: { total: data.size }
        }
    end

    # GET /:id
    def show
      render json: {
        data: @theme.as_json(:making_detail)
      }
    end

    # PATCH/PUT /:id
    def update
      ActiveRecord::Base.transaction do
        @theme.content = theme_params[:content] unless theme_params[:content].nil?
        @theme.caution = theme_params[:caution] unless theme_params[:caution].nil?
        @theme.caution_bold = theme_params[:caution_bold] unless theme_params[:caution_bold].nil?
        @theme.start_address = theme_params[:start_address] unless theme_params[:start_address].nil?
        @theme.start_position = theme_params[:start_position] unless theme_params[:start_position].nil?
        case theme_params[:difficulty]
        when "easy"
          @theme.theme_type = theme_params[:difficulty]
          @theme.difficulty = 0
        when "normal"
          @theme.theme_type = theme_params[:difficulty]
          @theme.difficulty = 5
        when "hard"
          @theme.theme_type = theme_params[:difficulty]
          @theme.difficulty = 10
        end
        case theme_params[:render_type]
        when "swiper"
          @theme.render_type = Model::RenderType::Swiper.new
        when "scroll"
          @theme.render_type = Model::RenderType::Scroll.new
        when "text"
          @theme.render_type = Model::RenderType::Text.new
        end
        @theme.price = theme_params[:price] unless theme_params[:price].nil?
        @theme.play_time = theme_params[:play_time] unless theme_params[:play_time].nil?
        @theme.use_memo = theme_params[:use_memo] unless theme_params[:use_memo].nil?
        @theme.has_deadline = theme_params[:has_deadline] unless theme_params[:has_deadline].nil?
        @theme.deadline = theme_params[:deadline] unless theme_params[:deadline].nil?
        @theme.is_reviewable = theme_params[:is_reviewable] unless theme_params[:is_reviewable].nil?
        @theme.is_rankable = theme_params[:is_rankable] unless theme_params[:is_rankable].nil?
        @theme.need_agreement = theme_params[:need_agreement] unless theme_params[:need_agreement].nil?
        @theme.play_user_count = theme_params[:play_user_count] unless theme_params[:play_user_count].nil?
        @theme.publish_type = theme_params[:publish_type] unless theme_params[:publish_type].nil?
        
        @theme.save!

        set_data(@theme.as_json(:making_detail))
        respond("성공")
      end
    end

    # DELETE /:id
    def destroy
      if @theme.super_theme.destroy
        respond("성공")
      else
        raise_error("실패", 4000)
      end
    end

    # PATCH /:id/upload_image
    def upload_image
      # ImageType = :profile, :preview
      ActiveRecord::Base.transaction do
        image = @theme.images.create!(type: params[:image_type])
        image.attach(params[:file])

        set_data(image)
        respond("성공")
      end
    end

    # DELETE /:id/remove_image
    def remove_image
      @image = Model::Image.find_by(id: params[:image_id])
      raise_error("존재하지 않는 이미지", 4000) if @image.nil?

      if @image.destroy
        respond("이미지 삭제 성공")
      else
        raise_error("이미지 삭제 실패", 4001)
      end
    end

    private
      def set_theme
        @theme = constant.find_by_fake_id(params[:id])
      end

      def constant
        Model.config.theme.constant
      end

      def theme_params
        params.fetch(:theme, {}).permit(
          :content,
          :summary,
          :has_caution,
          :caution,
          :caution_bold,
          :start_address,
          :start_position,
          :difficulty,
          :render_type,
          :price,
          :play_time,
          :has_deadline,
          :deadline,
          :is_reviewable,
          :is_rankable,
          :need_agreement,
          :play_user_count,
          :use_memo,
          :publish_type
        )
      end
  end
end