require 'minitest_helper'
require 'rogguer/sprites/coordinates'

include Rogguer::Sprites::Conversions

describe Rogguer::Sprites::Coordinates do

  let(:coordinates) do 
    Rogguer::Sprites::Coordinates.new
  end

  describe "conversion function" do
    it "should convert an array" do
      converted_array = Coordinates([1,2])
      converted_array.must_be_instance_of Rogguer::Sprites::Coordinates
      converted_array.x.must_equal 1
      converted_array.y.must_equal 2
    end

    it "should default y=0 with a single element array" do
      converted_array = Coordinates([1])
      converted_array.must_be_instance_of Rogguer::Sprites::Coordinates
      converted_array.x.must_equal 1
      converted_array.y.must_equal 0
    end

    it "should convert from existing coords" do
      coordinates.coords = [4, 5]
      converted_coords = Coordinates(coordinates)
      converted_coords.must_be_instance_of Rogguer::Sprites::Coordinates
      converted_coords.wont_be_same_as coordinates
      converted_coords.must_equal coordinates
    end

    it "should otherwise raise a type error" do
      proc {
        Coordinates("hi there")
      }.must_raise TypeError
    end
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

  describe "equality" do
    it "should equal other coords with the same x/y vals" do
      first_coords = Rogguer::Sprites::Coordinates.new(1,2)
      second_coords = Rogguer::Sprites::Coordinates.new(1,2)

      first_coords.must_equal second_coords
    end

    it "should not equal other coords with different x/y vals" do
      first_coords = Rogguer::Sprites::Coordinates.new(1,2)
      second_coords = Rogguer::Sprites::Coordinates.new(2,1)

      first_coords.wont_equal second_coords
    end
  end

end

