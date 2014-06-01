module Rogguer
  require_relative 'sprites'

  class GameMaster
    attr_reader :map

    def initialize(map_board)
      @map = map_board
      @hero = Rogguer::Sprites.build(:hero)
      @hero.coords = calculate_starting_coords(@map)
      @map.place(@hero)
    end

    def move_hero(direction)
      @hero.intends_to_move(direction)
      @map.move_to_intent(@hero)
      @hero.commit_move!
    end

    private

    def calculate_starting_coords(map)
      [@map.structure.last.size / 2, @map.structure.size - 1]
    end
  end
end
