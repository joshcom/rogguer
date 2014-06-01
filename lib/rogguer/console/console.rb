module Rogguer
  module Consoles
    class Console
      def setup
        raise NotImplementedError
      end

      def teardown
        raise NotImplementedError
      end

      def draw
        raise NotImplementedError
      end
    end
  end
end
