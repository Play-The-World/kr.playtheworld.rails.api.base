module Serializer
  class User# < Struct.new(:topics)
    class << self
      def profile(email)
        user = Model::User.joins(:entries, :teams, :plays).first
        p user

      end
    end
  end
end