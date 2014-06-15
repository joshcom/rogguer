module Rogguer
  class BattleMaster
    attr_reader :hero, :enemy

    def initialize(hero, enemy)
      @hero  = hero
      @enemy = enemy
    end
  end
end
