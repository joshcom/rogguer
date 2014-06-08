require 'minitest_helper'
require 'rogguer/sprites/rock'

describe Rogguer::Sprites::Rock do
  let(:tile) do
    "o"
  end

  let(:sprite) do 
    Rogguer::Sprites::Rock.new(tile)
  end

  it "should be an enemy" do
    sprite.enemy?().must_equal true
  end

  it "should not be a hero" do
    sprite.hero?().must_equal false
  end

  it "should be not passable" do
    sprite.passable?().must_equal false
  end
end

