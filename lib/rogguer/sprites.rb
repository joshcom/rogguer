# Load all the sprite classes
Dir[File.dirname(__FILE__) + '/sprites/*.rb'].each do |file| 
  require file 
end

module Rogguer
  require_relative "configurations/yaml_configuration"

  module Sprites
    def self.build(sprite_sym)
      tile = self.configuration[sprite_sym.to_s]
      if tile.nil?
        raise NameError, "#{sprite_sym.inspect} is an unsupported sprite"
      end

      begin
        Rogguer::Sprites.const_get(classify(sprite_sym).to_sym).new(tile)
      rescue NameError
        Rogguer::Sprites::Sprite.new(tile)
      end
    end

    def self.build_by_tile(tile)
      sprite = self.configuration.invert[tile]
      self.build(sprite)
    end

    def self.build_from_sprite(sprite_sym, sprite)
      new_sprite = self.build(sprite_sym)
      new_sprite.copy(sprite)
      new_sprite
    end

    private

    def self.configuration
      @configuration ||= Rogguer::Configurations::YamlConfiguration.new("tiles")
      @configuration.file
    end

    def self.classify(string)
      string.to_s.split('_').collect(&:capitalize).join
    end
  end
end
