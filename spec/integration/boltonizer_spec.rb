require "spec_helper"
require_relative "../../lib/console"

describe Boltonizer do
  let(:boltonizer) { Boltonizer.new }

  def coordinates
    coordinates = boltonizer.coordinates
    [coordinates.x, coordinates.y, coordinates.direction]
  end
  
  describe "PLACE" do
    context "with correct coordinates" do
      it "places correctly" do
        boltonizer.do("PLACE 1,2,EAST")
        expect(boltonizer.response).to eq("Done.")
        expect(coordinates).to eq([1, 2, :east])
      end
    end
    
    context "with incorrect coordinates" do
      it "shows an error" do
        boltonizer.do("PLACE 6,2,SOUTH")
        expect(boltonizer.response).to eq("Incorrect coordinates. Don't forget I am inside 5x5 grid!")
      end
    end
  end
  
  describe "MOVE" do
    it "moves correctly" do
      boltonizer.do("PLACE 0,0,NORTH")
  
      boltonizer.do("MOVE")
      expect(boltonizer.response).to eq("Done.")
      expect(coordinates).to eq([0, 1, :north])
  
      boltonizer.do("MOVE")
      expect(boltonizer.response).to eq("Done.")
      expect(coordinates).to eq([0, 2, :north])
    end
    
    it "doesn't move outside table" do
      boltonizer.do("PLACE 0,0,SOUTH")
      boltonizer.do("MOVE")
      expect(boltonizer.response).to eq("Incorrect coordinates. Don't forget I am inside 5x5 grid!")
    end
  end
  
  describe "LEFT and RIGHT" do
    it do
      boltonizer.do("PLACE 0,0,SOUTH")

      boltonizer.do("LEFT")
      expect(boltonizer.response).to eq("Done.")
      expect(coordinates).to eq([0, 0, :east])

      boltonizer.do("LEFT")
      expect(boltonizer.response).to eq("Done.")
      expect(coordinates).to eq([0, 0, :north])

      boltonizer.do("RIGHT")
      expect(boltonizer.response).to eq("Done.")
      expect(coordinates).to eq([0, 0, :east])
    end
    
    it "does nothing when not on the table" do
      boltonizer.do("LEFT")
      expect(boltonizer.response).to eq("Please PLACE me on the table first.")
    end
  end
  
  describe "REPORT" do
    it "reports current position" do
      boltonizer.do("PLACE 1,2,WEST")
      boltonizer.do("REPORT")
      
      expect(boltonizer.response).to eq("X: 1, Y: 2, direction: WEST")
    end
  end

  describe "Unknown command" do
    it "prints an error" do
      error_message = "Unknown command. Commands I understand: PLACE, MOVE, EXIT, LEFT, RIGHT, REPORT"
      
      boltonizer.do("HELLO 1,2,SOUTH")
      expect(boltonizer.response).to eq(error_message)
  
      boltonizer.do("hi")
      expect(boltonizer.response).to eq(error_message)
      
      boltonizer.do("PLACE")
      expect(boltonizer.response).to eq(error_message)
      
      boltonizer.do("PLACE 1,b,SOUTH")
      expect(boltonizer.response).to eq(error_message)
      
      boltonizer.do("PLACE 0,0,WHAT")
      expect(boltonizer.response).to eq(error_message)
    end
  end
end
