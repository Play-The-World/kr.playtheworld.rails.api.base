module V1::Playing
  class PlaysController < BaseController
    before_action :authenticate_user!

    def current_stage_lists
    end
  end
end
