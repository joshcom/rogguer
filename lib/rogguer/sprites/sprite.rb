module Rogguer
  module Sprites
    class Sprite
      require 'forwardable' 
      require_relative 'coordinates'

      extend Forwardable
      include Rogguer::Sprites::Conversions

      attr_reader :coords, :intent, :tile
      def_delegators :@coords, :x, :y, :to_a

      def initialize(tile)
        @coords = Rogguer::Sprites::Coordinates.new
        @intent = nil
        @tile = tile
      end

      def passable?
        true
      end

      def hero?
        false
      end

      def enemy?
        false
      end

      def passable?
        !enemy? && !hero?
      end

      def sitting_on_tile=(tile)
        @sitting_on_tile = tile
      end
      
      def sitting_on_tile
        @sitting_on_tile
      end

      def coords=(new_coords)
        @coords = Coordinates(new_coords)
      end

      def intent=(new_coords)
        @intent = Coordinates(new_coords)
      end

      def intends_to_move(direction)
        @intent = @coords.dup
        @intent.move(direction)
      end

      def intends_to_move?
        !@intent.nil?
      end

      def commit_move!
        return unless intends_to_move?

        @coords = @intent
        @intent = nil
      end
    end
  end
end
