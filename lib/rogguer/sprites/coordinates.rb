module Rogguer
  module Sprites

    module Conversions
      module_function

      def Coordinates(*args)
        case args.first
        when Array
          c = args.first
          Rogguer::Sprites::Coordinates.new(c.first, c.fetch(1, 0))
        when Coordinates
          args.first.dup
        else
          raise TypeError, 
            "Cannot convert #{args.inspect} to Coordinates"
        end
      end
    end

    class Coordinates
      attr_accessor :x, :y

      def initialize(x = 0, y = 0)
        @x = Integer(x) 
        @y = Integer(y)
      end

      def ==(other_coords)
        @x == other_coords.x && @y == other_coords.y
      end

      def to_a
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
