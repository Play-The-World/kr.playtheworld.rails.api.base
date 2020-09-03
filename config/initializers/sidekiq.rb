case Rails.env.to_sym
when :development, :test
  db = 0
when :production
  db = 1
else
  db = 2
end

Sidekiq.configure_server do |config|
  config.redis = {
    url: Settings.redis.url,
    db: db
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: Settings.redis.url,
    db: db
  }
end

Sidekiq.default_worker_options = {
  # queue: :default,
  backtrace: true,
  # dead: true,
  # retry: true,
}

Sidekiq::Bouncer.configure do |config|
  config.redis = Rails.application.redis
end