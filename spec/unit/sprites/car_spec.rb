require 'minitest_helper'
require 'rogguer/sprites/car'

describe Rogguer::Sprites::Car do
  let(:tile) do
    "C"
  end

  let(:sprite) do 
    Rogguer::Sprites::Car.new(tile)
  end

  it "should be an enemy" do
    sprite.enemy?().must_equal true
  end

  it "should not be a hero" do
    sprite.hero?().must_equal false
  end

  it "should not be passable" do
    sprite.passable?().must_equal false
  end

  it "should be fightable" do
    sprite.fightable?().must_equal true
  end
end

