module Rogguer
  require_relative 'sprite'

  module Sprites
    class Rock < Sprite
      def enemy?
        true
      end
    end
  end
end
