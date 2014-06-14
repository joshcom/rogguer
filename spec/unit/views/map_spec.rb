require 'minitest_helper'
require 'rogguer/views/map'

describe Rogguer::Views::Map do
  let(:map) do
    Rogguer::Views::Map.new(:default)
  end

  let(:piece) do
    Rogguer::Sprites.build(:hero)
  end

  let(:coords_off_map) do
    [map.structure.size, map.structure.first.size]
  end

  before do
    piece.coords = [1, 3]
    piece.intent = [2, 3]
  end

  describe "initialization" do
    it "should build the map structure" do
      map.structure.wont_be_nil
      map.structure.must_be_instance_of Array
      map.structure.first.must_be_instance_of Array
    end
  end

  describe "update structure" do
    it "should happily update the struture with the piece code" do
      map.update(piece)
      map.structure[piece.y][piece.x].must_equal piece.tile
    end
  end

  describe "allowable intents" do
    it "should not be allowed to move off of the map" do
      piece.intent = coords_off_map
      map.allowable_intent?(piece).must_equal false
    end

    it "should not be allowed to move to unpassable tile" do
      map.structure[piece.intent.y][piece.intent.x] = "*"
      map.allowable_intent?(piece).must_equal false
    end

    it "should be allowed to move on top of passable tiles" do
      map.allowable_intent?(piece).must_equal true
    end
  end

  describe "piece placement" do
    it "should record the tile under the piece, when placed" do
      original_tile = map.sprite_at_intent(piece).tile
      map.place(piece)
      piece.sitting_on_tile.must_equal original_tile
    end

    it "should update the structure when placing a piece" do
      map.place(piece)
      map.structure[piece.y][piece.x].must_equal piece.tile
    end
  end

  describe "location inspection" do
    let(:grass) do
      Rogguer::Sprites.build(:grass)
    end

    before do
      grass.coords = piece.intent
      map.update(grass)
    end

    it "should return a sprite for the given intent" do
      sprite = map.sprite_at_intent(piece)
      sprite.must_be_instance_of Rogguer::Sprites::Sprite
      sprite.tile.must_equal ","
    end

    it "should return nil if there is no tile at location of intent" do
      piece.intent = coords_off_map
      map.sprite_at_intent(piece).must_be_nil
    end
  end

  describe "movement to intent" do
    let(:original_tile) do
      original_tile = map.sprite_at_intent(piece).tile
    end

    before do
      piece.sitting_on_tile = "x"
    end

    it "should not update the structure if the piece does not intent to move" do
      mock = MiniTest::Mock.new
      mock.expect(:intends_to_move?, false)

      map.move_to_intent(mock)
      mock.verify

      map.sprite_at_intent(piece).tile.must_equal original_tile
    end

    it "should update structure if the piece moves" do
      tile_at_intent = original_tile
      original_intent = piece.intent
      original_location = piece.coords
      map.move_to_intent(piece)

      piece.sitting_on_tile.must_equal tile_at_intent
      map.structure[original_location.y][original_location.x].must_equal "x"
      map.structure[original_intent.y][original_intent.x].must_equal piece.tile
    end

  end
end

