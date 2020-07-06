module V1::Making
  class BaseController < ::V1::BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    before_action :authenticate_user!#, only: [:create]
    
    def test
    end

    def authenticate_user!
      super
      current_user.create_maker!(name: current_user.nickname) if current_user.maker.nil? and !current_user.nickname.nil?
    end
  end
end
