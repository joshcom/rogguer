require 'minitest_helper'
require 'rogguer/sprites/coordinates'

describe Rogguer::Sprites::Coordinates do
  let(:coordinates) do 
    Rogguer::Sprites::Coordinates.new
  end

  describe "instantiation" do
    it "should start at 0,0 by default" do
      coordinates.to_coords.must_equal [0, 0]
    end

    it "should be initializable from points" do
      new_coords = Rogguer::Sprites::Coordinates.new(2,3)
      new_coords.x.must_equal 2
      new_coords.y.must_equal 3
    end

    it "should be buildable from another coordinates instance" do
      coordinates.x = 4
      coordinates.y = 5

      new_coords = Rogguer::Sprites::Coordinates.build_from_coords(coordinates)
      new_coords.to_coords.must_equal [4, 5]
    end
  end

  describe "coordinates" do
    it "should have settable coordinates" do
      coordinates.coords = [7, 8]
      coordinates.x.must_equal 7
      coordinates.y.must_equal 8
    end

    it "should convert parameters" do
      coordinates.coords = ["9","10"]
      coordinates.x.must_equal 9
      coordinates.y.must_equal 10
    end

    it "should raise an exception on non-convertable parameters" do
      proc {
        coordinates.coords = ["a","b"]
      }.must_raise ArgumentError
    end
  end

  describe "movement" do
    before do
      coordinates.coords = [1, 1]
    end

    it "should move left" do
      coordinates.move(:left)
      coordinates.to_coords.must_equal [0, 1]
    end

    it "should move right" do
      coordinates.move(:right)
      coordinates.to_coords.must_equal [2, 1]
    end

    it "should move up" do
      coordinates.move(:up)
      coordinates.to_coords.must_equal [1, 0]
    end

    it "should move down" do
      coordinates.move(:down)
      coordinates.to_coords.must_equal [1, 2]
    end

    it "should have no movement on non-recognized type" do
      coordinates.move(:diagonal)
      coordinates.to_coords.must_equal [1, 1]
    end

    it "should have an overridable magnitude" do
      coordinates.move(:down, 4)
      coordinates.to_coords.must_equal [1, 5]
    end
  end

end

