class V1::BaseController < ApplicationController
  include Pagy::Backend
  # before_action :authenticate_user
  after_action { pagy_headers_merge(@pagy) if @pagy }

  Error = ::Error

  # Exception handler
  rescue_from Error::Base do |e|
    render_error(e)
  end
  # TODO: Production에서만 활성화하기.
  # rescue_from StandardError do |e|
  #   error = Error::Standard.new
  #   render_error(error)
  # end

  # axios이상함..
  def user_params
    pa = params.fetch(:user, {})
    pa = JSON.parse(pa) if pa.is_a?(String)
    # pa.permit(:email, :password, :password_confirmation, :nickname, :email_confirmation)
    result = {}
    pa.each { |k, v| result[k.to_sym] = v }
    result
  end

  protected
    def respond(message = nil, status = Response::DEFAULT_STATUS, code = nil)
      response = { response: Response.new(message, code) }
      response.merge!({ data: @data }) if @data
      response.merge!({ meta: @meta }) if @meta
      render json: response, status: status
    end
    # def raise_error(message = nil, code = nil, status = nil)
    def raise_error(message = nil, status = nil, code = nil)
      raise Error::Standard.new(message, code, status)
    end
    def render_error(e)
      render json: e, status: e.status
      # render text: nil, status: e.status
    end
    def set_data(data)
      @data = {} if @data.nil?
      data = data.as_json unless data.is_a?(Hash)
      @data.merge!(data)
    end
    def set_meta(meta)
      @meta = meta
      @meta = @meta.as_json unless meta.is_a?(Hash)
    end

  private
    def pagy_get_vars(collection, vars)
      # vars[:count] ||= cache_count(collection)
      vars[:count]   = collection.count(:all)
      vars[:items]   = params[:items].to_i if params[:items]
      vars[:page]  ||= params[ vars[:page_param] || Pagy::VARS[:page_param] ]
      vars
    end

    # def cache_count(collection)
    #   cache_key = "pagy-#{collection.model.name}:#{collection.to_sql}"
    #   Rails.cache.fetch(cache_key, expires_in: 20 * 60) do
    #     collection.count(:all)
    #   end
    # end

    def authenticate_user!
      # raise_error("로그인 필요", 1000, :unauthorized) if current_user.nil?
      raise_error("로그인 필요", :unauthorized) if current_user.nil?
    end
    
    def current_user
      # Model.current.user ||= Model::User.find(session[:user_id])
      @current_user ||= (session[:user_id] ? Model::User::Base.find_by(id: session[:user_id]) : nil)
      Model.current.user ||= @current_user
      @current_user
    end

    # def authenticate_user!
    #   decoded = JsonWebToken.decode(current_token)
    #   Model.current.user = User.find(decoded[:user_id])
    # end
    # def current_token
    #   request&.headers['Authorization']&.split(' ').last
    # end
end