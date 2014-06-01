module Rogguer
  require_relative 'sprite'

  module Sprites
    class Hero < Sprite
      def self.code
        "@"
      end

      def hero?
        true
      end
    end
  end
end
