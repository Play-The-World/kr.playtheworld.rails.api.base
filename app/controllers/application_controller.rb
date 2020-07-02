class ApplicationController < ActionController::API
  # include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::MimeResponds
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
end
