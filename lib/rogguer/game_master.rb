module Rogguer
  require_relative 'sprites'

  class GameMaster
    DEFAULT_STARTING_LEVEL = 1

    attr_reader :status_bar, :map

    def initialize(status_bar, map_board)
      @current_level = DEFAULT_STARTING_LEVEL
      @status_bar = status_bar
      @map = map_board
      @hero = Rogguer::Sprites.build(:hero)
      @hero.coords = calculate_starting_coords(@map)
      @map.place(@hero)

      update_status_bar
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

      update_status_bar
    end

    private

    def update_status_bar
      @status_bar.update(@current_level, @hero.lives, @hero.steps)
    end

    def calculate_starting_coords(map)
      [@map.structure.last.size / 2, @map.structure.size - 1]
    end
  end
end
