module Rogguer
  require_relative 'sprite'

  module Sprites
    class Hero < Sprite
      def hero?
        true
      end
    end
  end
end
