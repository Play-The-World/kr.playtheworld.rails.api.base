module V1::Playing
  class MainController < BaseController
    # skip_before_action :authenticate_user!, except: [:index]

    def news
      # main_post = Model::Topic::MainPost.includes(
      #   :posts
      # ).with_translations.all
      main_post = Model::Topic::MainPost.first
      banners = Model::Topic::Banner.includes(
        super_themes: [
          locations: [:translations],
          genres: [:translations],
          categories: [:translations],
        ]
      ).with_translations.all
      render json: {
        main_post: main_post.as_json(),
        banners: banners.as_json()
      }
    end

    def banners
      render json: {
        main_post: {
          type: "notice",
          id: 1,
          title: "플레이더월드 뉴스! 플더월 리뉴얼!"
        },
        banners: [
          {
            type: "theme",
            id: 1,
            data: {
              type: "super_theme",
              id: "sadffwaefa",
              title: "김부장 프로젝트",
              summary: "꼰대력을 자랑하는 HR 1부 김부장이\n편지 한 장만 두고 사라졌다?!?",
              categories: [
                { title: "오프라인" }
              ],
              genres: [
                { title: "코믹" }
              ],
              locations: [
                { title: "세종문화회관" }
              ],
              images: [
                {
                  type: "thumbnail",
                  url: "https://t.playthe.world/t.png"
                }
              ]
            },
            styles: [
              {
                type: "background_color",
                value: "#0074ff"
              }
            ]
          }
        ]
      }
    end
    
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
