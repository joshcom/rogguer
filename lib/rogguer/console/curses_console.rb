require_relative 'console'

module Rogguer
  module Consoles
    require 'curses'
    class CursesConsole < Rogguer::Consoles::Console
      def setup
        Curses.noecho     # do not show typed keys
        Curses.curs_set 0 # Hide the cursor
        Curses.stdscr.keypad = true
        Curses.init_screen
      end

      def teardown
        Curses.close_screen
      end

      def draw(map)
        line_num   = 0
        column_num = 0

        map.each do |line| 
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
    end
  end
end
