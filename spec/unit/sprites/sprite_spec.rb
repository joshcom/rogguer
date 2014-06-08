require 'minitest_helper'
require 'rogguer/sprites/sprite'

describe Rogguer::Sprites::Sprite do
  let(:tile) do
    "."
  end

  let(:sprite) do 
    Rogguer::Sprites::Sprite.new(tile)
  end

  describe "default state" do

    it "should start at 0,0" do
      sprite.to_a.must_equal [0, 0]
    end

    it "should have no intent" do
      sprite.intent.must_be_nil
    end

    it "should preserve the initialized tile" do
      sprite.tile.must_equal tile
    end

    it "is passable" do
      sprite.passable?().must_equal true
    end

    it "is not a hero" do
      sprite.hero?().must_equal false
    end

    it "is not an enemy" do
      sprite.enemy?().must_equal false
    end
  end

  describe "copy" do
    it "can copy data from another sprite" do
      other_sprite = Rogguer::Sprites::Sprite.new(",")
      other_sprite.coords = [5,5]
      other_sprite.intent = [6,6]
      other_sprite.sitting_on_tile = "o"

      sprite.copy(other_sprite)
      sprite.coords.to_a.must_equal [5,5]
      sprite.intent.to_a.must_equal [6,6]
      sprite.sitting_on_tile.must_equal "o"
    end
  end

  describe "the tile below the sprite" do
    it "should be nil, by default" do
      sprite.sitting_on_tile.must_be_nil
    end

    it "should be settable" do
      sprite.sitting_on_tile = ","
      sprite.sitting_on_tile.must_equal ","
    end
  end

  describe "sprite movement intentions" do
    let(:coordinates) do
      [2,3]
    end

    before do
      sprite.intent = coordinates
    end

    it "should have not intent do move by default" do
      Rogguer::Sprites::Sprite.new(".").intends_to_move?().must_equal false
    end

    it "can intend to move to specific coordinates" do
      sprite.intends_to_move?().must_equal true
    end

    it "will intend to move to a coordinate" do
      sprite.intent.must_be_instance_of Rogguer::Sprites::Coordinates
      sprite.intent.to_a.must_equal coordinates
    end

    it "will update the x, y coords on commit" do
      sprite.commit_move!
      sprite.to_a.must_equal coordinates
      sprite.intent.must_be_nil
    end

    it "can intend to move in a direction" do
      sprite.intends_to_move(:right)
      sprite.intent.to_a.must_equal [1,0]
    end
  end

end

