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
end

