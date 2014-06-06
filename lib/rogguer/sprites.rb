# Load all the sprite classes
Dir[File.dirname(__FILE__) + '/sprites/*.rb'].each do |file| 
  require file 
end

module Rogguer
  require 'yaml'

  module Sprites
    CONFIG_LOCATION = "../../../config/tiles.yml"

    def self.build(sprite)
      tile = self.configuration[sprite.to_s]
      Rogguer::Sprites.const_get(classify(sprite).to_sym).new(tile)
    end

    def self.build_by_tile(tile)
      sprite = self.configuration.invert[tile]
      self.build(sprite)
    end

    private

    def self.configuration
      @configuration ||= YAML.load_file(File.expand_path(CONFIG_LOCATION, 
                            __FILE__))
      @configuration
    end

    def self.classify(string)
      string.to_s.split('_').collect(&:capitalize).join
    end
  end
end
