class ApplicationController < ActionController::API
  # include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Cookies
  # include ActionController::RequestForgeryProtection
  include ActionController::MimeResponds
  # protect_from_forgery with: :exception
  # before_action :set_csrf_cookie
  respond_to :json
  # around_action :set_current_user

  def cors_preflight
    render nothing: true
  end

  private
    # https://stackoverflow.com/a/2513456
    def set_current_user
      Model::Current.user = current_user
      yield
    ensure
      # to address the thread variable leak issues in Puma/Thin webserver
      Model::Current.user = nil
    end
    # def set_csrf_cookie
    #   cookies["CSRF-TOKEN"] = form_authenticity_token
    # end
end
