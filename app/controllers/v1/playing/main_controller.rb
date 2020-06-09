module V1::Playing
  class MainController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]
    
    def topics
      # data = Model::Repository::Topic.new.current_topics_with_super_themes
      # data = Model::SuperTheme::Base.with_translations(:ko).eager_load(:themes, genres: [:translations]).all
      # data = Repository::Theme.each_for_genre(genre: "코믹", translation: :ko)
      data = Repository::Theme.each_for_location(location: "온라인", translation: :ko)
      render json: serializer.topics(data)
    end

    def create_new_play
      user = Model::User.last
      user ||= Model::User.create!(email: "#{SecureRandom.hex(2)}@aa.aa", password: "123456", password_confirmation: "123456")
      team = Model::Team.last
      team ||= Model::Team.create(name: SecureRandom.hex(2), content: "초보 환영")
      Model::Entry.where(user: user, team: team).first_or_create
      sp = Model::SuperPlay::Base.create!(team: team, super_theme_id: Model::SuperTheme::Base.first.id)
      
      team.users.each do |user|
        sp.plays.create(user: user,theme_data_id: sp.super_theme.id)
      end
    end

    private
      def serializer
        Serializer::Main
      end
  end
end
