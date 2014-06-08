module Rogguer
  require_relative 'sprites'

  class Map
    MAP_LOCATION = "../../../config/maps/"
    MAP_SUFFIX   = ".map"

    attr_reader :structure

    def initialize(map)
      @file = File.new(File.expand_path("#{MAP_LOCATION}#{map}#{MAP_SUFFIX}", 
                __FILE__), 'r')
      @structure = nil
      build_structure!
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

    def build_structure!
      @structure = [[]] # This may be best extracted.
      @file.chars.each do |character|
        if newline?(character)
          @structure << [] 
          next
        else
          @structure.last << character
        end
      end

      @structure.delete_at(@structure.size - 1 ) while @structure.last.empty?
    end

    def tile_at(coords)
      @structure.fetch(coords.last).fetch(coords.first)
    end

    def newline?(character)
      character == "\n" || character == "\r"
    end
  end
end
