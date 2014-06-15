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

      @enemies = {}

      update_status_bar
      initialize_enemies
    end

    def hero_action(direction)
      return if @hero.dead?

      @hero.intends_to_move(direction)
      sprite_at_intent = @map.sprite_at_intent(@hero)

      if sprite_at_intent && sprite_at_intent.enemy?
        if sprite_at_intent.fightable?
         fight!(sprite_at_intent) 
        else
          @hero = Rogguer::Sprites.build_from_sprite(:dead_hero, @hero)
        end
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

    def fight!(sprite)
      @fighting = true
    end

    def fighting?
      @fighting == true
    end

    private

    def update_status_bar
      @status_bar.update(@current_level, @hero.lives, @hero.steps)
    end

    def initialize_enemies
      # TODO: Figure out semi-random starting positions for enemies
      # based on level, etc.
      enemy = Rogguer::Sprites.build(:car)
      enemy.coords = [32, 13]
      @enemies[enemy.uuid] = enemy

      map.place(enemy)
    end

    def calculate_starting_coords(map)
      [@map.structure.last.size / 2, @map.structure.size - 1]
    end
  end
end
