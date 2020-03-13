class V1::BaseController < ApplicationController
  # include AutoGenDoc
  include Pagy::Backend
  extend ParameterValidator
  # before_action :authenticate_user!
  after_action { pagy_headers_merge(@pagy) if @pagy }

  rescue_from Apipie::ParamMissing do |exception|
    json = {
      exception.param.name => "required"
    }
    render status: :bad_request, json: {
      errors: json
    }
  end

  rescue_from Apipie::ParamInvalid do |exception|
    json = {
      exception.param.to_s => "invalid"
    }
    render status: :bad_request, json: {
      errors: json
    }
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render status: :not_found, json: {}
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    render status: :bad_request, json: {
      errors: exception.record.errors.messages
    }
  end

  protected
    def authenticate_user!
      decoded = JsonWebToken.decode(current_token)
      Model.current.user = User.find(decoded[:user_id])
    end
    def current_token
      request&.headers['Authorization']&.split(' ').last
    end
end