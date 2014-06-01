module Rogguer
  require_relative 'map'
  require_relative 'console/curses_console'
  class Game
    def play
      console = Rogguer::Consoles::CursesConsole.new
      map = Rogguer::Map.new(:default)

      begin
        console.setup

        game_loop do 
          # Each tick:
          # * Get user input
          # * Check to see if user wants to pause, or
          #   quit.
          # * Check for collisions, and move user
          # * Move MoBs
          # * Redraw map
          console.draw(map.structure)
        end
      ensure
        console.teardown
      end
    end

    private

    def game_loop 
      yield
      sleep(5)
    end
  end
end
