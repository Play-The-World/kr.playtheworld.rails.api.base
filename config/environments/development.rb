Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  # config.action_mailer.raise_delivery_errors = false

  # config.action_mailer.perform_caching = false

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      address:              'smtp.gmail.com',
      port:                 587,
      user_name:            Rails.application.credentials.gmail[:user_name],
      password:             Rails.application.credentials.gmail[:password],
      authentication:       'plain',
      enable_starttls_auto: true 
    }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_options = {
    from: 'no-reply@playthe.world'
  }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Disable this functionality on development environment
  config.hosts = nil

  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Store files locally.
  # config.active_storage.service = :local
  config.active_storage.service = :amazon

  # Set host
  self.default_url_options = { host: "localhost:3000" }

  # AutoLoad
  model_path = "../model/app/models/model/**/*.rb"
  config.eager_load_paths += Dir[model_path]
  ActiveSupport::Reloader.to_prepare do
    Dir[model_path].each { |f| require_dependency("#{Dir.pwd}/#{f}") }
  end
end
