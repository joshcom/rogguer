module Rogguer
  module Consoles
    class Console
      def setup
        raise NotImplementedError
      end

      def teardown
        raise NotImplementedError
      end

      def draw(status_bar, map)
        raise NotImplementedError
      end

      def last_command
        raise NotImplementedError
      end
    end
  end
end
