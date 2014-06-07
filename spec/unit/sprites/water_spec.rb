require 'minitest_helper'
require 'rogguer/sprites/water'

describe Rogguer::Sprites::Water do
  let(:tile) do
    "o"
  end

  let(:sprite) do 
    Rogguer::Sprites::Water.new(tile)
  end

  it "should be an enemy" do
    sprite.enemy?().must_equal true
  end

  it "should not be a hero" do
    sprite.hero?().must_equal false
  end

  it "should be passable" do
    sprite.passable?().must_equal true
  end
end

