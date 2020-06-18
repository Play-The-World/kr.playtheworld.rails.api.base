class V1::BaseController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user
  after_action { pagy_headers_merge(@pagy) if @pagy }

  private
    def pagy_get_vars(collection, vars)
      vars[:count] ||= cache_count(collection)
      vars[:items] = params[:items].to_i if params[:items]
      vars[:page]  ||= params[ vars[:page_param] || Pagy::VARS[:page_param] ]
      vars
    end

    def cache_count(collection)
      cache_key = "pagy-#{collection.model.name}:#{collection.to_sql}"
      Rails.cache.fetch(cache_key, expires_in: 20 * 60) do
        collection.count(:all)
      end
    end

    def authenticate_user
      @user = current_user
    end
    def authenticate_user!
      if current_user.nil?
        render json: {
            message: "로그인 필요.",
            code: 1000
          }, status: :unauthorized
      end
    end
    
    def current_user
      # Model.current.user ||= Model::User.find(session[:user_id])
      Model::User.find_by(id: session[:user_id])
    end
    # def authenticate_user!
    #   decoded = JsonWebToken.decode(current_token)
    #   Model.current.user = User.find(decoded[:user_id])
    # end
    def current_token
      request&.headers['Authorization']&.split(' ').last
    end
end