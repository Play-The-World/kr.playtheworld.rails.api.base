Apipie.configure do |config|
  config.app_name                = "PlayTheWorld API"
  config.api_base_url            = "/"
  config.doc_base_url            = "/docs"

  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"

  config.translate               = false
  # config.default_locale          = nil
  config.default_locale          = "ko"

  config.copyright = "&copy; 2020 PLAY THE WORLD"

  # Swagger
  config.swagger_content_type_input = :json
  config.swagger_api_host = "localhost:3000"
end
