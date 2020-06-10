module Repository
  class User
    class << self
      def profile(email)
        user = set_user(email)
        p user
      end

      def themes
        user = set_user
        p user.entries
      end

      private
      def set_user(email)
        Model::User.preload(:teams, :plays).first
      end
    end
  end
end