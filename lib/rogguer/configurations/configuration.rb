module Rogguer
  module Configurations
    class Configuration
      CONFIG_FOLDER_LOCATION = "../../../../config/"

      def initialize(name, subdirectory = "")
        @name = name
        @subdirectory = subdirectory
      end

      def config_folder_location
        CONFIG_FOLDER_LOCATION
      end

      def suffix
        ""
      end

      def file
         @file ||= File.new(file_path, 'r')
      end

      protected

      def file_path
        File.expand_path("#{config_folder_location}#{@subdirectory}#{@name}"+
                         "#{suffix}", __FILE__)
      end
    end
  end
end
