Apipie.configure do |config|
  config.app_name                = "PlayTheWorld API"
  config.api_base_url            = "/"
  config.doc_base_url            = "/docs"

  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"

  config.default_locale          = "ko"
end
