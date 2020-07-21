module V1::Making
  class TestController < BaseController
    # skip_before_action :authenticate_user!, only: [:upload_images, :image, :index_theme]
    skip_before_action :authenticate_user!, only: [:upload_images, :image]
    before_action :set_theme, only: [:update_theme, :show_theme, :destroy_theme]

    def index_theme
      # data = Model::User::Base.find(25).plain_themes
      data = current_user.plain_themes

      @pagy, themes = pagy(data)
      result = themes.map do |a|
        JSON.parse(a.value)
      end

      # themes.as_json.each do |a|
      #   puts a[:theme_number]
      # end
      set_data(result)
      set_meta({ total: data.size })
      respond("성공", 200)
    end

    def create_theme
      data = params[:data]
      theme_number = data[:themeNumber]
      raise_error("themeNumber는 필수 요소 입니다.", 404) if theme_number.nil?

      t = current_user.plain_themes.create!(theme_number: theme_number, value: data.to_json)

      set_data(t)
      respond("성공", 201)
    end

    def update_theme
      @theme.update!(value: @data.to_json)
      set_data(@theme)
      respond("성공", 200)
    end
    
    def show_theme
      set_data(@theme)
      respond("성공", 200)
    end

    def destroy_theme
      if @theme.destroy
        respond("삭제 성공", 200)
      else
        raise_error("삭제 실패", 400)
      end
    end
    
    # POST
    def upload_images
      data = params[:images].map do |image|
        d = Base64.strict_encode64(image.read)
        Model::PlainImage.create!(value: d, filesize: image.size, filename: image.original_filename, content_type: image.content_type)
      end
      # 1개 테스트용
      # image = params[:images]
      # d = Base64.strict_encode64(image.read)
      # data = Model::PlainImage.create!(value: d, filesize: image.size, filename: image.original_filename, content_type: image.content_type)

      set_data(data)
      respond("성공", 200)
    end

    # GET
    def image
      i = Model::PlainImage.find(params[:id].to_i)
      # i = Model::PlainImage.last
      send_data Base64.decode64(i.value), type: i.content_type, disposition: 'inline'
    end

    private
      def set_theme
        @data = params[:data]
        theme_number = @data[:themeNumber]

        @theme = current_user.plain_themes.find_by(theme_number: theme_number)
        raise_error("테마를 찾을 수 없습니다.", 404) if @theme.nil?
      end
  end
end
