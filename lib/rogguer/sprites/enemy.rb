module Rogguer
  require_relative 'sprite'

  module Sprites
    class Enemy < Sprite
      def enemy?
        true
      end

      def fightable?
        true
      end
    end
  end
end
