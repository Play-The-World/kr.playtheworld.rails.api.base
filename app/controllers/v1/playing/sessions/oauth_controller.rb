module V1::Playing::Sessions
  class OauthController < V1::Playing::BaseController
    # before_action :authenticate_user!

    # PROVIDERS = ['naver', 'google', 'kakao', 'facebook', 'apple']

    # POST
    def connect
      user = nil

      case params[:provider]
      when 'naver'
        user = naver
      else
        raise_error('알 수 없는 provider')
      end

      raise_error('로그인에 실패하였습니다.') if user.nil?

      # sign_in user
      session[:user_id] = user.id
      set_data({ user: user })
      respond
    end

    private
      def naver
        uri = URI('https://nid.naver.com/oauth2.0/token')
        par = {
          grant_type: 'authorization_code',
          client_id: 'OfUDL6hfZe9jM03z888O',
          client_secret: 'jXrjC_LYdk',
          code: params[:code],
          state: SecureRandom.alphanumeric
        }
        uri.query = URI.encode_www_form(par)
        res = Net::HTTP.get_response(uri)
        
        raise_error('실패') unless res.is_a?(Net::HTTPSuccess)
        
        info = JSON.parse(res.body)
        
        # 로그인 중이 아니라면 이메일 주소 알아오기
        uri = URI('https://openapi.naver.com/v1/nid/me')
        # req = Net::HTTP::Get.new(uri)
        req = Net::HTTP::Post.new(uri)
        req['Authorization'] = "Bearer #{info["access_token"]}"

        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) {|http|
          http.request(req)
        }

        unless res.is_a?(Net::HTTPSuccess)
          puts res.body["message"]
          raise_error('실패')
        end

        info2 = JSON.parse(res.body)

        Model::User::Base.connect_provider({
          provier: 'naver',
          type: :oauth2,
          email: info2["response"]["email"],
          uid: info2["response"]["id"],
          access_token: info["access_token"],
          refresh_token: info["refresh_token"]
        }, current_user)
      end
  end
end

# curl  -XGET "https://openapi.naver.com/v1/nid/me" \
#       -H "Authorization: Bearer AAAANngFaP6pUuiFPv7JX3ZX43bVL0jQqNNDhcWkAEt4RqJtTnY6NZiMwpRZPLp6AO6DhHrMuzDPf-du8FYbFPtHp-A"