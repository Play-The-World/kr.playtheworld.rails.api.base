module Repository
  class Theme
    class << self
      def each_for_genre(genre:, translation: :ko)
        # type: ["today", "online", "offline", "challenge", "creation"]
        # Model::SuperTheme::Base.joins(:images).where(type: type, status: "default")
        Model::SuperTheme::Base.with_translations(translation).eager_load(:themes, genres: :translations).where("model_genre_translations.title = ?", genre)
      end

      def each_for_location(location:, translation: :ko)
        Model::SuperTheme::Base.with_translations(translation).eager_load(:themes, locations: :translations).where("model_location_translations.title = ?", location)
      end
    end
  end
end