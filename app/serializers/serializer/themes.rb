module Serializer
  class themes# < Struct.new(:topics)
    class << self
      def topics(data)
        data.map do |d|
          {
            titleTheme: d.title,
            content: d.super_themes.map { |s|
              {
                themeName: s.title,
                themePlace: "온라인",
                themeGenre: s.genres.take.title,
                themeImageUrl: s.images.where(type: :poster).take.url
              }
            }
          }
        end
      end

      def topics2
        topics = Model::Topic::Base.arel_table
        application = Model::Application.arel_table
        super_themes = Model::SuperTheme::Base.arel_table
        a = topics.join(:application, Arel::Nodes::OuterJoin).on(application[:mode].matches("development"))
          .join(:super_themes, Arel::Nodes::OuterJoin)
          .project(topics[:id])
        puts a
        puts Model::Topic::Base.where(a)
      end
    end
  end
end