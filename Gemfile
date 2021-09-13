source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1'
# Use Puma as the app server
gem 'puma'#, '~> 4.3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.7.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :production do
  gem 'model', path: 'engines/model'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # API Docs
  gem 'rspec-rails'
  gem 'rswag-specs'
end

group :development do
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Error Page
  gem "better_errors"
  gem "binding_of_caller"

  gem 'model', path: '../model'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Middleware
# Rack middleware for blocking & throttling abusive requests
# gem 'rack-attack' # https://github.com/kickstarter/rack-attack
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors' # https://github.com/cyu/rack-cors

# Configuration
gem 'config' # https://github.com/railsconfig/config

# Security
# Use Json Web Token (JWT) for token based authentication
gem 'jwt' # https://github.com/jwt/ruby-jwt

# Database
# Use mongodb as a database
# gem 'mongoid', '~> 7.0.5'
# Use mysql as a database
gem 'mysql2'

# Model
gem 'pagy' #, '~> 3.7.0'  # https://github.com/ddnexus/pagy

# AWS S3 for active-stroage
gem "aws-sdk-s3", require: false

# RDoc
# gem "hanna-nouveau" # https://github.com/ruby/hanna-nouveau

# API Docs
# gem 'zero-rails_openapi' # https://github.com/zhandao/zero-rails_openapi/
# gem 'apipie-rails' # https://github.com/Apipie/apipie-rails
# gem 'rswag-api'
# gem 'rswag-ui'

# Real-time WebSocket
gem 'pusher' # https://github.com/pusher/pusher-http-ruby

# ActiveJob
gem 'sidekiq' # https://github.com/mperham/sidekiq
gem 'redis' # https://redis.io
gem 'hiredis' # https://github.com/redis/hiredis

# Procfile-based application
# gem 'foreman' # https://github.com/ddollar/foreman
gem 'invoker' # https://invoker.codemancers.com