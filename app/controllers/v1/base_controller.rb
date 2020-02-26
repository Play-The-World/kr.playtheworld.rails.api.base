class V1::BaseController < ApplicationController
  # before_action :authenticate_user!

  protected
    def authenticate_user!
      decoded = JsonWebToken.decode(current_token)
      # @current_user = User.find(decoded[:user_id])
    end
    def current_token
      header = request.headers['Authorization']
      header = header.split(' ').last if header
    end
end