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
      theme_param = param[:theme]
      raise_error unless theme_param

      ActiveRecord::Base.transaction do
        @theme.super_theme.update!(title: theme_param[:title]) unless theme_param[:title].nil?
        @theme.content = theme_param[:themeDescription] unless theme_param[:themeDescription].nil?
        case theme_param[:themeType]
        when "swiper"
          @theme.render_type = Model::RenderType::Swiper.new
        when "scroll"
          @theme.render_type = Model::RenderType::Scroll.new
        when "text"
          @theme.render_type = Model::RenderType::Text.new
        end
        @theme.play_type = theme_param[:playType] unless theme_param[:playType].nil?
        classification = @theme.super_theme.classifications.where(classifier_type: "Model::Category").take
        case theme_param[:onOffType]
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
        if theme_param[:addFunction]
          if theme_param[:addFunction][:attention]
            att_param = theme_param[:addFunction][:attention]
            @theme.caution = att_param[:brifEmphasisMessage]
            @theme.caution_bold = att_param[:emphasisMessage]
            @theme.need_agreement = att_param[:getUserAgree] unless att_param[:getUserAgree].nil?
            @theme.has_caution = att_param[:isUse] unless att_param[:isUse].nil?
          end
          if theme_param[:addFunction][:dueDate]
            @theme.deadline = theme_param[:addFunction][:dueDate][:endDate]
            @theme.has_deadline = theme_param[:addFunction][:dueDate][:isUse]
          end
          if theme_param[:addFunction][:infoMessage]
            @theme.additional_text = theme_param[:addFunction][:infoMessage][:message]
            @theme.has_additional_text = theme_param[:addFunction][:infoMessage][:isUse]
          end
          @theme.use_memo = theme_param[:addFunction][:memo] unless theme_param[:addFunction][:memo].nil?
          @theme.is_rankable = theme_param[:addFunction][:rank] unless theme_param[:addFunction][:rank].nil?
          @theme.is_reviewable = theme_param[:addFunction][:review] unless theme_param[:addFunction][:review].nil?
        end
        # genre
        case theme_param[:level]
        when "easy"
          @theme.theme_type = theme_param[:level]
          @theme.difficulty = 0
        when "normal"
          @theme.theme_type = theme_param[:level]
          @theme.difficulty = 5
        when "hard"
          @theme.theme_type = theme_param[:level]
          @theme.difficulty = 10
        end
        @theme.play_user_count = theme_param[:participant] unless theme_param[:participant].nil?
        @theme.play_time = theme_param[:playTime] unless theme_param[:playTime].nil?
        if theme_param[:publish]
          pp = theme_param[:publish]
          @theme.publish_alert = pp[:alarm] unless pp[:alarm].nil?
          @theme.publish_type = pp[:alarm] unless pp[:type].nil?
        end
        if theme_param[:startPosition]
          pp = theme_param[:startPosition]
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
        @theme.super_theme.update!(title: theme_param[:title]) unless theme_param[:title].nil?
        @theme.content = theme_param[:content] unless theme_param[:content].nil?
        @theme.caution = theme_param[:caution] unless theme_param[:caution].nil?
        @theme.caution_bold = theme_param[:caution_bold] unless theme_param[:caution_bold].nil?
        @theme.start_address = theme_param[:start_address] unless theme_param[:start_address].nil?
        @theme.start_position = theme_param[:start_position] unless theme_param[:start_position].nil?
        case theme_param[:difficulty]
        when "easy"
          @theme.theme_type = theme_param[:difficulty]
          @theme.difficulty = 0
        when "normal"
          @theme.theme_type = theme_param[:difficulty]
          @theme.difficulty = 5
        when "hard"
          @theme.theme_type = theme_param[:difficulty]
          @theme.difficulty = 10
        end
        case theme_param[:render_type]
        when "swiper"
          @theme.render_type = Model::RenderType::Swiper.new
        when "scroll"
          @theme.render_type = Model::RenderType::Scroll.new
        when "text"
          @theme.render_type = Model::RenderType::Text.new
        end
        @theme.price = theme_param[:price] unless theme_param[:price].nil?
        @theme.play_time = theme_param[:play_time] unless theme_param[:play_time].nil?
        @theme.use_memo = theme_param[:use_memo] unless theme_param[:use_memo].nil?
        @theme.has_deadline = theme_param[:has_deadline] unless theme_param[:has_deadline].nil?
        @theme.deadline = theme_param[:deadline] unless theme_param[:deadline].nil?
        @theme.is_reviewable = theme_param[:is_reviewable] unless theme_param[:is_reviewable].nil?
        @theme.is_rankable = theme_param[:is_rankable] unless theme_param[:is_rankable].nil?
        @theme.need_agreement = theme_param[:need_agreement] unless theme_param[:need_agreement].nil?
        @theme.play_user_count = theme_param[:play_user_count] unless theme_param[:play_user_count].nil?
        @theme.publish_type = theme_param[:publish_type] unless theme_param[:publish_type].nil?
        @theme.publish_alert = theme_param[:publish_alert] unless theme_param[:publish_alert].nil?
        @theme.has_teaser_stage = theme_param[:has_teaser_stage] unless theme_param[:has_teaser_stage].nil?
        
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
        raise_error("실패", 400)
      end
    end

    # POST /:id/image
    def create_image
      # ImageType = :profile, :preview
      ActiveRecord::Base.transaction do
        image = @theme.images.create!(
            type: param[:image][:type],
            order: param[:image][:order]
          )
        image.attach(param[:image][:file])

        set_data(image)
        respond("성공", 201)
      end
    end

    # PATCH /:id/image
    def update_image
      ActiveRecord::Base.transaction do
        image = @theme.images.find(param[:image][:id])
        image.type = param[:image][:type] unless param[:image][:type].nil?
        image.order = param[:image][:order] unless param[:image][:order].nil?
        image.attach(param[:image][:file]) unless param[:image][:file].nil?

        set_data(image)
        respond("성공")
      end
    end

    # DELETE /:id/remove_image
    def remove_image
      @image = @theme.images.find_by(id: param[:image][:id])
      raise_error("존재하지 않는 이미지", 404) if @image.nil?

      if @image.destroy
        respond("이미지 삭제 성공")
      else
        raise_error("이미지 삭제 실패", 400)
      end
    end

    private
      def set_theme
        @theme = constant.find_by_fake_id(param[:id])
        raise_error("해당 테마를 찾을 수 없습니다.", 404) if @theme.nil?
      end

      def constant
        Model.config.theme.constant
      end

      # def theme_param
      #   param.fetch(:theme, {}).permit(
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