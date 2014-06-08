require_relative 'console'

module Rogguer
  module Consoles
    require 'curses'
    class CursesConsole < Rogguer::Consoles::Console

      # Define these in Console base.
      CURSES_COMMANDS = {
        Curses::Key::UP => :up,
        Curses::Key::DOWN => :down,
        Curses::Key::LEFT => :left,
        Curses::Key::RIGHT => :right
      }

      def setup
        Curses.noecho     # do not show typed keys
        Curses.curs_set 0 # Hide the cursor
        Curses.stdscr.keypad = true
        Curses.init_screen
      end

      def teardown
        Curses.close_screen
      end

      def draw(status_bar, map)
        line_num   = 0
        column_num = 0

        map.structure.each do |line| 
          line.each do |character|
            Curses.setpos(line_num, column_num)
            Curses.addstr(character)
            column_num += 1
          end
          line_num   += 1
          column_num = 0
        end

        Curses.refresh
      end

      def last_command
        CURSES_COMMANDS[Curses.getch]
      end
    end
  end
end
