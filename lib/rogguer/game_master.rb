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
      return if @hero.dead?

      @hero.intends_to_move(direction)
      sprite_at_intent = @map.sprite_at_intent(@hero)

      if sprite_at_intent && sprite_at_intent.enemy?
        @hero = Rogguer::Sprites.build_from_sprite(:dead_hero, @hero)
      end

      if !@map.allowable_intent?(@hero)
        @hero.intent = @hero.coords
      end

      if @map.allowable_intent?(@hero)
        @map.move_to_intent(@hero)
        @hero.commit_move!
      else
        @map.update(@hero)
      end
    end

    private

    def calculate_starting_coords(map)
      [@map.structure.last.size / 2, @map.structure.size - 1]
    end
  end
end
