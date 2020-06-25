module V1::Making
  class ThemesController < BaseController
    # skip_before_action :authenticate_user!, only: [:create]
    before_action :set_theme, except: [:index]
  
    # GET /
    def index
      data = constant.includes(
          :images
        ).with_translations
      # data = constant.joins(
      #     locations: :translations,
      #     genres: :translations,
      #     categories: :translations,
      #     themes: :translations,
      #   ).with_translations
      # data = constant.includes(:classifications, :themes).with_translations
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
        @theme.content = theme_params[:content]
        @theme.caution = theme_params[:caution]
        @theme.caution_bold = theme_params[:caution_bold]
        @theme.start_address = theme_params[:start_address]
        @theme.start_position = theme_params[:start_position]
        @theme.difficulty = theme_params[:difficulty]
        @theme.render_type = theme_params[:render_type]
        @theme.price = theme_params[:price]
        @theme.play_time = theme_params[:play_time]
        @theme.use_memo = theme_params[:use_memo]
        @theme.has_deadline = theme_params[:has_deadline]
        @theme.deadline = theme_params[:deadline]
        @theme.is_reviewable = theme_params[:is_reviewable]
        @theme.is_rankable = theme_params[:is_rankable]
        @theme.need_agreement = theme_params[:need_agreement]
        @theme.play_user_count = theme_params[:play_user_count]
        @theme.publish_type = theme_params[:publish_type]
        
        @theme.save!

        set_data(@theme.as_json(:making_detail))
        respond
      end
    end

    # DELETE /:id
    def destroy
    end

    # PATCH /:id/upload_image
    def upload_image
    end

    # DELETE /:id/remove_image
    def remove_image
      @image = Model::Image.find_by(id: params[:image_id])
      @image.destroy
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