module Rogguer
  module Views
    require_relative 'screen_view'

    class Battle < ScreenView

      def config_folder
        "ansi_art/"
      end

      protected

      def build_structure!
        super

        build_my_structure
      end

      def build_my_structure
        @structure << []
        @structure << "(R) Ribbit, (J) Jump".split("")
      end

    end
  end
end
