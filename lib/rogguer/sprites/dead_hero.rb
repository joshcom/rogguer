module Rogguer
  require_relative 'hero'

  module Sprites
    class DeadHero < Hero
      def dead?
        true
      end
    end
  end
end
