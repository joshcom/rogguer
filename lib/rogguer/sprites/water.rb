module Rogguer
  require_relative 'enemy'

  module Sprites
    class Water < Enemy
      def enemy?
        true
      end

      def fightable?
        false
      end

      def passable?
        true
      end
    end
  end
end
