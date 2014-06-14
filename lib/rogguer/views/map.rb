module Rogguer
  module Views
    require_relative '../sprites'
    require_relative 'screen_view'

    class Map < ScreenView

      attr_reader :structure

      def config_folder
        "maps/"
      end

      def allowable_intent?(piece)
        sprite = sprite_at_intent(piece)
        return false if sprite.nil?


        sprite.passable?
      end

      def place(piece)
        piece.sitting_on_tile = @structure[piece.y][piece.x]
        update(piece)
      end

      def update(piece)
        @structure[piece.y][piece.x] = piece.tile
      end

      def move_to_intent(piece)
        return unless piece.intends_to_move?

        @structure[piece.y][piece.x] = piece.sitting_on_tile
        piece.sitting_on_tile = tile_at(piece.intent.to_a)
        @structure[piece.intent.y][piece.intent.x] = piece.tile
      end

      def sprite_at_intent(piece)
        map_tile = nil

        begin
          map_tile = tile_at(piece.intent.to_a)
        rescue IndexError
          return nil
        end

        Rogguer::Sprites.build_by_tile(map_tile)
      end

      private

      def tile_at(coords)
        @structure.fetch(coords.last).fetch(coords.first)
      end
    end
  end
end
