module Rogguer
  module Views
    require_relative "../configurations/yaml_configuration"
    class StatusBar
      attr_accessor :steps, :lives, :level

      def initialize
        @level = 0
        @lives = 0
        @steps = 0
      end

      def update(level, lives, steps)
        @level = level
        @lives = lives
        @steps = steps
      end

      def level_text
        "#{configuration["level_text"]}: #{level}"
      end

      def lives_text
        "#{configuration["lives_text"]}: #{lives}"
      end

      def steps_text
        "#{configuration["steps_text"]}: #{steps}"
      end

      def title_text
        configuration["title_text"]
      end

      private

      def configuration
        @configuration ||= Rogguer::Configurations::YamlConfiguration.new("status_bar")
        @configuration.file
      end
    end
  end
end
