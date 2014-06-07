require 'minitest_helper'
require 'rogguer/sprites'

describe Rogguer::Sprites do
  describe "sprite symbol builder" do
    it "should build a sprite from known labels" do
      hero = Rogguer::Sprites.build(:hero)
      hero.must_be_instance_of Rogguer::Sprites::Hero
      hero.tile.must_equal "@"
    end

    it "should default to sprite base class on generic tiles" do
      grass = Rogguer::Sprites.build(:grass)
      grass.must_be_instance_of Rogguer::Sprites::Sprite
      grass.tile.must_equal ","
    end

    it "should do something else when no tile is defined" do
      proc {
        Rogguer::Sprites.build(:wall)
      }.must_raise NameError
    end

  end

  describe "tile builder" do
    it "should build a sprite for a known tile" do
      grass = Rogguer::Sprites.build_by_tile(",")
      grass.must_be_instance_of Rogguer::Sprites::Sprite
      grass.tile.must_equal ","
    end

    it "should raise a NameError on an unknown tile" do
      proc {
        Rogguer::Sprites.build_by_tile "J"
      }.must_raise NameError
    end
  end

  describe "sprite instance builder" do
    it "should copy the location information from the passed in sprite" do
      hero = Rogguer::Sprites.build(:hero)
      hero.coords = [2,3]
      hero.intent = [4,5]
      hero.sitting_on_tile = "."

      corpse = Rogguer::Sprites.build_from_sprite(:dead_hero, hero)
      corpse.coords.to_a.must_equal [2,3]
      corpse.intent.to_a.must_equal [4,5]
      corpse.sitting_on_tile.must_equal "."
    end
  end
end

