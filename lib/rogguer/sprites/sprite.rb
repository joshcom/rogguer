module Rogguer
  module Sprites
    class Sprite
      require 'forwardable' 
      extend Forwardable

      attr_reader :coords, :intent
      def_delegators :@coords, :x, :y, :to_coords,
        :coords=

      def self.code
        raise NotImplementedError
      end

      def initialize
        @coords = Rogguer::Sprites::Coordinates.new
        @intent = nil
      end

      def code
        self.class.code
      end

      def hero?
        false
      end

      def enemy?
        false
      end

      def to_str
        code
      end

      def to_s
        to_str
      end

      def sitting_on_code=(code)
        @sitting_on_code = code
      end
      
      def sitting_on_code
        @sitting_on_code
      end

      def intent=(new_coords)
        @intent = Rogguer::Sprites::Coordinates.new(new_coords.first,
            new_coords.last)
      end

      def intends_to_move(direction)
        @intent = Rogguer::Sprites::Coordinates.build_from_coords(@coords)
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
