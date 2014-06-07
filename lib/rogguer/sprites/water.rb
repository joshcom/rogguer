module Rogguer
  require_relative 'sprite'

  module Sprites
    class Water < Sprite
      def enemy?
        true
      end

      def passable?
        true
      end
    end
  end
end
