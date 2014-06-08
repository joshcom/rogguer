module Rogguer
  require_relative 'sprite'

  module Sprites
    class Hero < Sprite
      attr_reader :steps, :lives

      def initialize(tile)
        @steps = 0
        @lives = 0
        super
      end

      def hero?
        true
      end

      def dead?
        false
      end

      def copy(from_sprite)
        if from_sprite.hero?
          @steps = from_sprite.steps
          @lives = from_sprite.lives
        end

        super
      end

      def commit_move!
        return unless intends_to_move?
        @steps += 1

        super
      end
    end
  end
end
