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

        map_width = map.structure.first.length

        line_num = draw_top_status_bar(status_bar, line_num, map_width)

        map.structure.each do |line| 
          line.each do |character|
            Curses.setpos(line_num, column_num)
            Curses.addstr(character)
            column_num += 1
          end
          line_num   += 1
          column_num = 0
        end

        line_num = draw_bottom_status_bar(status_bar, line_num, map_width)

        Curses.refresh
      end

      def draw_top_status_bar(status_bar, current_line_number, width)
        title = status_bar.title_text
        level = status_bar.level_text
        text = fill_text_with_padding(title, level, width)
        draw_status_bar_text(text, current_line_number)
      end

      def draw_bottom_status_bar(status_bar, current_line_number, width)
        lives = status_bar.lives_text
        steps = status_bar.steps_text
        text = fill_text_with_padding(lives, steps, width)
        draw_status_bar_text(text, current_line_number)
      end

      def draw_status_bar_text(text, current_line_number)
        Curses.setpos(current_line_number, 0)
        Curses.addstr(text)
        current_line_number += 1
      end

      def fill_text_with_padding(left_text, right_text, width)
        padding_needed = width - (left_text.length + right_text.length) 
        padding_needed = 0 if padding_needed < 0

        padding_text = ""
        padding_needed.times { |x| padding_text += " " }

        "#{left_text}#{padding_text}#{right_text}"
      end

      def last_command
        CURSES_COMMANDS[Curses.getch]
      end
    end
  end
end
