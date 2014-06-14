module Rogguer
  module Views
      require_relative '../configurations/text_configuration'

      class ScreenView
        attr_reader :structure

        def initialize(type)
          @type = type
          @structure = nil
          build_structure!
        end

        def config
          @config ||= Rogguer::Configurations::TextConfiguration.new(@type, 
                        config_folder)
        end

        def config_folder
          ""
        end

        protected

        def build_structure!
          @structure = [[]] # This may be best extracted.
          config.file.chars.each do |character|
            if newline?(character)
              @structure << [] 
              next
            else
              @structure.last << character
            end
          end

          @structure.delete_at(@structure.size - 1 ) while @structure.last.empty?
        end

        def newline?(character)
          character == "\n" || character == "\r"
        end
      end
  end
end
