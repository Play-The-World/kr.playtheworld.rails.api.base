module V1
  class PusherController < BaseController
    def auth
      # TODO channel_name에 따른 접근권한
      response = Pusher.authenticate(params[:channel_name], params[:socket_id], {
        user_id: @current_user.id, # => required
        user_info: {
          nickname: @current_user.nickname,
          email: @current_user.email
        }
      })
      render json: response
    end
  end
end