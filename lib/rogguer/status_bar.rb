module Rogguer
  class StatusBar
    CONFIG_LOCATION = "../../../config/status_bar.yml"

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
      @configuration ||= YAML.load_file(File.expand_path(CONFIG_LOCATION, 
                            __FILE__))
      @configuration
    end
  end
end
