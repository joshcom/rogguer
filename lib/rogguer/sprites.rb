# Load all the sprite classes
Dir[File.dirname(__FILE__) + '/sprites/*.rb'].each do |file| 
  require file 
end

module Rogguer
  module Sprites
    def self.build(sprite)
      Rogguer::Sprites.const_get(classify(sprite).to_sym).new
    end

    private

    def self.classify(string)
      string.to_s.split('_').collect(&:capitalize).join
    end
  end
end
