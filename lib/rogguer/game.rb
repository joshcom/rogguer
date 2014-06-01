module Rogguer
  require_relative 'map'
  require_relative 'console/curses_console'
  require_relative 'game_master'

  class Game
    TICK_TIME = 0.20

    def play
      console = Rogguer::Consoles::CursesConsole.new
      map = Rogguer::Map.new(:default)
      game_master = Rogguer::GameMaster.new(map)

      begin
        console.setup

        last_command = nil

        game_loop do 
          # TODO
          # * Configuration
          # * Menu
          # * Check to see if user wants to pause, or
          #   quit.
          # * Check for collisions
          # * Move MoBs
          # * Clear stack of input each tick
          console.draw(game_master.map)
          sleep(TICK_TIME)
          last_command = console.last_command
          game_master.move_hero(last_command)
        end
      ensure
        console.teardown
      end
    end

    private

    def game_loop 
      yield while true
    end
  end
end
