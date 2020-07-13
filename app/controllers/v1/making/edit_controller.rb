module V1::Making
  class EditController < BaseController
    before_action :set_theme, except: [:index]
  
    def stage_lists
      ActiveRecord::Base.transaction do
        td = @theme.current_theme_data

        params[:stage_list].each do |sl|
          # 새로운 SL
          if sl[:id].nil?
            s = Model::StageList.new
          else
            s = td.stage_lists.find(sl[:id])
          end

          s.title = sl[:title]
          s.type = sl[:type]
          s.stage_list_number = sl[:stageListNo] unless sl[:stageListNo].nil?
          s.save!
        end
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
        respond("성공", 201)
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
      raise_error("존재하지 않는 이미지", 404) if @image.nil?

      if @image.destroy
        respond("이미지 삭제 성공")
      else
        raise_error("이미지 삭제 실패", 400)
      end
    end

    private
      def set_theme
        @theme = constant.find_by_fake_id(params[:id])
        raise_error("해당 테마를 찾을 수 없습니다.", 404) if @theme.nil?
      end

      def constant
        Model.config.theme.constant
      end
  end
end