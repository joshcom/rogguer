module Rogguer
  require 'securerandom'
  require_relative 'sprite'

  module Sprites
    class Enemy < Sprite
      attr_reader :uuid

      def initialize(tile)
        super

        @uuid = SecureRandom.uuid
      end

      def enemy?
        true
      end

      def fightable?
        true
      end
    end
  end
end
