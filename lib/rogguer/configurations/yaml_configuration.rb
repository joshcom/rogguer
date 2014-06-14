module Rogguer
  module Configurations
    require 'yaml'
    require_relative 'configuration'

    class YamlConfiguration < Configuration
      def suffix
        ".yml"
      end

      def file
         @file ||= YAML.load_file(file_path)
      end
    end
  end
end
