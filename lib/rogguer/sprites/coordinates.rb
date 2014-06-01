module Rogguer
  module Sprites
    class Coordinates
      attr_accessor :x, :y

      def self.build_from_coords(coords)
        self.new(coords.x, coords.y)
      end

      def initialize(x = 0, y = 0)
        @x = Integer(x) 
        @y = Integer(y)
      end

      def to_coords
        [x, y]
      end

      def coords=(new_coords)
        @x = Integer(new_coords.first)
        @y = Integer(new_coords.last)
      end

      def move(direction, magnitude=1)
        case direction
        when :left
          @x -= magnitude
        when :right
          @x += magnitude
        when :up
          @y -= magnitude
        when :down
          @y += magnitude
        end
      end
    end
  end
end
