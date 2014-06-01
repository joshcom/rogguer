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

    private

    def build_structure!
      @structure = [[]] # This may be best extracted.
      @file.chars.each do |character|
        @structure.last << character
        @structure << [] if newline?(character)
      end
    end

    def newline?(character)
      character == "\n" || character == "\r"
    end
  end
end
