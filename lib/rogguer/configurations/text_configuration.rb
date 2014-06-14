module Rogguer
  module Configurations
    require_relative 'configuration'

    class TextConfiguration < Configuration
      def suffix
        ".txt"
      end
    end
  end
end
