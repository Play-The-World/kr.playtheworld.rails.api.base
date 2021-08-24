require_relative 'boot'

require "rails"
# Pick the frameworks you want:
# require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PlayTheWorldAPI
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Internationalization
    I18n.available_locales = [:en, :ko]
    config.encoding = "utf-8"
    config.time_zone = "Seoul"
    config.i18n.default_locale = :ko

    # Middlewares
    # Session
    # config.session_store :cookie_store, key: '_ptw_session'
    config.session_store :cookie_store,
      # domain: 'localhost',
      # secure: true, # for HTTPS
      secure: Rails.env.production?,
      # same_site: :none,
      httponly: true,
      key: '_playtheworld',
      expire_after: nil
    config.middleware.use ActionDispatch::Cookies # Required for all session management (regardless of session_store)
    config.middleware.use config.session_store, config.session_options
    config.action_dispatch.cookies_serializer = :json

    # Rack::Attack.enabled = false

    # config.action_dispatch.default_headers = {
    #   'Access-Control-Allow-Origin' => '*',
    #   'Access-Control-Request-Method' => 'GET, PATCH, PUT, POST, OPTIONS, DELETE',
    #   'Access-Control-Allow-Headers:' => 'Origin, X-Requested-With, Content-Type, Accept'
    # }

    # Autoloads
    # [
    #   %W(#{config.root}/lib),
    # ].each { |path| config.autoload_paths += path }

    # Annotations
    config.annotations.register_directories("engines")
    config.annotations.register_tags("TESTME")

    # ActiveJob
    # You can not use prefix with sidekiq. ref: https://github.com/mperham/sidekiq/issues/4034
    # config.active_job.queue_name_prefix = Settings.active_job.prefix
    config.active_job.queue_adapter = :sidekiq
  end
end
