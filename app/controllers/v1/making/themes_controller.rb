module V1::Making
  class ThemesController < BaseController
    before_action :set_theme, except: [:index]
  
    # GET /
    def index
      data = current_user.maker.themes.includes(
          translations: [],
          images: [],
          super_theme: [:translations]
        )

      # data = constant.includes(
      #     translations: [],
      #     images: [],
      #     super_theme: [:translations]
      #   )
      @pagy, @themes = pagy(data)
      render json: {
          data: @themes.as_json(:making),
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
      theme_params = params[:theme]
      raise_error unless theme_params

      ActiveRecord::Base.transaction do
        @theme.super_theme.update!(title: theme_params[:title]) unless theme_params[:title].nil?
        @theme.content = theme_params[:themeDescription] unless theme_params[:themeDescription].nil?
        case theme_params[:themeType]
        when "swiper"
          @theme.render_type = Model::RenderType::Swiper.new
        when "scroll"
          @theme.render_type = Model::RenderType::Scroll.new
        when "text"
          @theme.render_type = Model::RenderType::Text.new
        end
        @theme.play_type = theme_params[:playType] unless theme_params[:playType].nil?
        classification = @theme.super_theme.classifications.where(classifier_type: "Model::Category").take
        case theme_params[:onOffType]
        when "onLine"
          category = Model::Category.find_by(type: "online")
          if category.nil?
            @theme.super_theme.categories << category
          else
            classification.update!(classifier_id: category.id)
          end
        when "offLine"
          category = Model::Category.find_by(type: "offline")
          if category.nil?
            @theme.super_theme.categories << category
          else
            classification.update!(classifier_id: category.id)
          end
        end
        if theme_params[:addFunction]
          if theme_params[:addFunction][:attention]
            att_params = theme_params[:addFunction][:attention]
            @theme.caution = att_params[:brifEmphasisMessage]
            @theme.caution_bold = att_params[:emphasisMessage]
            @theme.need_agreement = att_params[:getUserAgree] unless att_params[:getUserAgree].nil?
            @theme.has_caution = att_params[:isUse] unless att_params[:isUse].nil?
          end
          if theme_params[:addFunction][:dueDate]
            @theme.deadline = theme_params[:addFunction][:dueDate][:endDate]
            @theme.has_deadline = theme_params[:addFunction][:dueDate][:isUse]
          end
          if theme_params[:addFunction][:infoMessage]
            @theme.additional_text = theme_params[:addFunction][:infoMessage][:message]
            @theme.has_additional_text = theme_params[:addFunction][:infoMessage][:isUse]
          end
          @theme.use_memo = theme_params[:addFunction][:memo] unless theme_params[:addFunction][:memo].nil?
          @theme.is_rankable = theme_params[:addFunction][:rank] unless theme_params[:addFunction][:rank].nil?
          @theme.is_reviewable = theme_params[:addFunction][:review] unless theme_params[:addFunction][:review].nil?
        end
        # genre
        case theme_params[:level]
        when "easy"
          @theme.theme_type = theme_params[:level]
          @theme.difficulty = 0
        when "normal"
          @theme.theme_type = theme_params[:level]
          @theme.difficulty = 5
        when "hard"
          @theme.theme_type = theme_params[:level]
          @theme.difficulty = 10
        end
        @theme.play_user_count = theme_params[:participant] unless theme_params[:participant].nil?
        @theme.play_time = theme_params[:playTime] unless theme_params[:playTime].nil?
        if theme_params[:publish]
          pp = theme_params[:publish]
          @theme.publish_alert = pp[:alarm] unless pp[:alarm].nil?
          @theme.publish_type = pp[:alarm] unless pp[:type].nil?
        end
        if theme_params[:startPosition]
          pp = theme_params[:startPosition]
          @theme.start_address = pp[:address]
          @theme.start_position = pp[:description]
        end

        @theme.save!

        set_data(@theme.as_json(:making_detail))
        respond("성공")
      end
    end

    # PATCH/PUT /:id
    def update_old
      ActiveRecord::Base.transaction do
        @theme.super_theme.update!(title: theme_params[:title]) unless theme_params[:title].nil?
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
        @theme.publish_alert = theme_params[:publish_alert] unless theme_params[:publish_alert].nil?
        @theme.has_teaser_stage = theme_params[:has_teaser_stage] unless theme_params[:has_teaser_stage].nil?
        
        @theme.save!

        set_data(@theme.as_json(:making_detail))
        respond("성공")
      end
    end

    # DELETE /:id/image
    def destroy
      if @theme.super_theme.destroy
        respond("성공")
      else
        raise_error("실패", 4000)
      end
    end

    # POST /:id/image
    def create_image
      # ImageType = :profile, :preview
      ActiveRecord::Base.transaction do
        image = @theme.images.create!(
            type: params[:image][:type],
            order: params[:image][:order]
          )
        image.attach(params[:image][:file])

        set_data(image)
        respond("성공")
      end
    end

    # PATCH /:id/image
    def update_image
      ActiveRecord::Base.transaction do
        image = @theme.images.find(params[:image][:id])
        image.type = params[:image][:type] unless params[:image][:type].nil?
        image.order = params[:image][:order] unless params[:image][:order].nil?
        image.attach(params[:image][:file]) unless params[:image][:file].nil?

        set_data(image)
        respond("성공")
      end
    end

    # DELETE /:id/remove_image
    def remove_image
      @image = @theme.images.find_by(id: params[:image][:id])
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
        raise_error("해당 테마를 찾을 수 없습니다.", 4998) if @theme.nil?
      end

      def constant
        Model.config.theme.constant
      end

      # def theme_params
      #   params.fetch(:theme, {}).permit(
      #     :title,
      #     :content,
      #     :summary,
      #     :has_caution,
      #     :caution,
      #     :caution_bold,
      #     :start_address,
      #     :start_position,
      #     :difficulty,
      #     :render_type,
      #     :price,
      #     :play_time,
      #     :has_deadline,
      #     :deadline,
      #     :is_reviewable,
      #     :is_rankable,
      #     :need_agreement,
      #     :play_user_count,
      #     :use_memo,
      #     :publish_type,
      #     :publish_alert,
      #     :has_teaser_stage
      #   )
      # end
  end
end