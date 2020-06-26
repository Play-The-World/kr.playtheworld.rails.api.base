# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

# require 'rack/cors'
# use Rack::Cors do

#   # allow all origins in development
#   allow do
#     origins ['localhost:8080', '192.168.0.83:8080']
#     resource '*', 
#         :headers => :any, 
#         :methods => [:get, :post, :delete, :put, :options]
#   end
# end