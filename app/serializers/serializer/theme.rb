module Serializer
  class Theme
    attr_reader :theme

    def initialize(theme:)
      @theme = theme
    end
  end
end