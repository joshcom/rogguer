require 'minitest_helper'
require 'rogguer/sprites/hero'

describe Rogguer::Sprites::Hero do
  let(:tile) do
    "@"
  end

  let(:sprite) do 
    Rogguer::Sprites::Hero.new(tile)
  end

  it "should not be an enemy" do
    sprite.enemy?().must_equal false
  end

  it "should be a hero" do
    sprite.hero?().must_equal true
  end

  it "should not be passable" do
    sprite.passable?().must_equal false
  end

  it "should not be dead" do
    sprite.dead?().must_equal false
  end

  describe "copy" do
    let(:other_hero) do
      Rogguer::Sprites::Hero.new(tile)
    end

    before do
      sprite.instance_variable_set(:@steps, 10)
      sprite.instance_variable_set(:@lives, 3)

      other_hero.instance_variable_set(:@steps, 2)
      other_hero.instance_variable_set(:@lives, 1)
      other_hero.coords = [5,5]
      other_hero.intent = [6,6]
      other_hero.sitting_on_tile = "o"
    end

    it "should copy steps and lives from other hero" do
      sprite.copy(other_hero)
      sprite.coords.to_a.must_equal [5,5]
      sprite.intent.to_a.must_equal [6,6]
      sprite.sitting_on_tile.must_equal "o"
      sprite.steps.must_equal 2 
      sprite.lives.must_equal 1
    end

    it "should copy data from non-heros" do
      other_sprite = Rogguer::Sprites::Sprite.new(",")
      other_sprite.coords = [5,5]
      other_sprite.intent = [6,6]
      other_sprite.sitting_on_tile = "o"

      sprite.copy(other_sprite)
      sprite.coords.to_a.must_equal [5,5]
      sprite.intent.to_a.must_equal [6,6]
      sprite.sitting_on_tile.must_equal "o"
      sprite.steps.must_equal 10
      sprite.lives.must_equal 3
    end
  end

  describe "movement" do
    before do
      sprite.instance_variable_set(:@steps, 0)
    end

    it "should take no steps when no movement is made" do
      sprite.commit_move!
      sprite.steps.must_equal 0
    end

    it "should take a step when committing a move" do
      sprite.intends_to_move(:up)
      sprite.commit_move!
      sprite.steps.must_equal 1
    end
  end
end

