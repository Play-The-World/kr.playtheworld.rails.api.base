class V2::BaseController < ApplicationController
  # include AutoGenDoc
  include Pagy::Backend
  # before_action :authenticate_user!
  after_action { pagy_headers_merge(@pagy) if @pagy }

  # api_dry :all do
  #   header! 'Token', String, desc: 'user token'
  # end

  # # Common :index parameters
  # api_dry :index do
  #   query :page, Integer, desc: 'page, greater than 1', range: { ge: 1 }, dft: 1
  #   query :rows, Integer, desc: 'data count per page',  range: { ge: 1 }, dft: 10
  # end

  # # Common parameters
  # api_dry [:show, :destroy, :update] do
  #   path! :id, Integer, desc: 'id'
  # end

  protected
    def authenticate_user!
      decoded = JsonWebToken.decode(current_token)
      Model.current.user = User.find(decoded[:user_id])
    end
    def current_token
      request&.headers['Authorization']&.split(' ').last
    end
end