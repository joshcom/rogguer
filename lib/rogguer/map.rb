module Rogguer
  class Map
    MAP_LOCATION = "../maps/"
    MAP_SUFFIX   = ".map"

    attr_reader :structure

    def initialize(map)
      @file = File.new(File.expand_path("#{MAP_LOCATION}#{map}#{MAP_SUFFIX}", 
                __FILE__), 'r')
      @structure = nil
      build_structure!
    end

    def place(piece)
      piece.sitting_on_code = @structure[piece.y][piece.x]
      @structure[piece.y][piece.x] = piece.code
    end

    def move_to_intent(piece)
      return unless piece.intends_to_move?

      @structure[piece.y][piece.x] = piece.sitting_on_code
      @structure[piece.intent.y][piece.intent.x] = piece.code
    end

    private

    def build_structure!
      @structure = [[]] # This may be best extracted.
      @file.chars.each do |character|
        @structure.last << character
        @structure << [] if newline?(character)
      end

      @structure.delete_at(@structure.size - 1 ) while @structure.last.empty?
    end

    def newline?(character)
      character == "\n" || character == "\r"
    end
  end
end
