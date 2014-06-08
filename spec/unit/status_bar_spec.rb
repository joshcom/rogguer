require 'minitest_helper'
require 'rogguer/status_bar'

describe Rogguer::StatusBar do
  let(:status_bar) do
    Rogguer::StatusBar.new
  end

  describe "initialization" do
    it "should default to zeros, by default" do
      status_bar.level.must_equal 0
      status_bar.lives.must_equal 0
      status_bar.steps.must_equal 0
    end
  end

  describe "updatable" do
    it "should update with a new level, lives, and steps" do
      status_bar.update(1, 3, 10)

      status_bar.level.must_equal 1
      status_bar.lives.must_equal 3
      status_bar.steps.must_equal 10
    end
  end

  describe "configurable text" do
    before do
      status_bar.update(1, 3, 10)
    end

    it "should construct levels text" do
      status_bar.level_text.must_equal "Level: 1"
    end

    it "should construct lives text" do
      status_bar.lives_text.must_equal "Lives: 3"
    end

    it "should construct steps text" do
      status_bar.steps_text.must_equal "Steps: 10"
    end

    it "should construct title text" do
      status_bar.title_text.must_equal "Rogguer"
    end
  end
end

