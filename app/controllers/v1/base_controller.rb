class V1::BaseController < ApplicationController
  include Pagy::Backend
  # before_action :authenticate_user!
  after_action { pagy_headers_merge(@pagy) if @pagy }

  protected
    def authenticate_user!
      decoded = JsonWebToken.decode(current_token)
      Model.current.user = User.find(decoded[:user_id])
    end
    def current_token
      request&.headers['Authorization']&.split(' ').last
    end
end