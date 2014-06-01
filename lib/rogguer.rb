require_relative "rogguer/version"
require_relative 'rogguer/game'

module Rogguer
  def self.play
    Game.new.play
  end
end
