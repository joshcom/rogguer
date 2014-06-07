module Rogguer
  require_relative 'sprite'

  module Sprites
    class Hero < Sprite
      def hero?
        true
      end

      def dead?
        false
      end
    end
  end
end
