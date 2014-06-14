module Rogguer
  require_relative 'views'
  require_relative 'game_master'
  require_relative 'console/curses_console'

  class Game
    TICK_TIME = 0.20

    def play
      console = Rogguer::Consoles::CursesConsole.new
      status_bar = Rogguer::Views::StatusBar.new
      map = Rogguer::Views::Map.new(:default)
      game_master = Rogguer::GameMaster.new(status_bar, map)

      begin
        console.setup

        last_command = nil

        game_loop do 
          console.draw(game_master.map, game_master.status_bar)
          sleep(TICK_TIME)
          last_command = console.last_command
          game_master.hero_action(last_command)

          fight_loop(game_master, console)
        end
      ensure
        console.teardown
      end
    end

    private

    def game_loop 
      yield while true
    end

    def fight_loop(game_master, console)
      battle = Rogguer::Views::Battle.new(:car)
      console.draw(battle)
      sleep(10) 
    end
  end
end
