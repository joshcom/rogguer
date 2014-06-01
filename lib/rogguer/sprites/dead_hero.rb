module Rogguer
  require_relative 'hero'

  module Sprites
    class DeadHero < Hero
      def self.code
        "%"
      end
    end
  end
end
