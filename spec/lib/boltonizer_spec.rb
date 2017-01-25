require "spec_helper"
require_relative "../../lib/boltonizer"

describe Boltonizer do
  let(:boltonizer) { described_class.new }
  
  describe "PLACE" do
    context "with correct coordinates" do
      let(:command) { "PLACE 1,2,EAST" }

      before { boltonizer.ask(command) }

      it { expect(boltonizer.response).to eq("Done.") }
      it { expect(boltonizer.coordinates.x).to eq(1) }
      it { expect(boltonizer.coordinates.y).to eq(2) }
      it { expect(boltonizer.coordinates.direction).to eq(:east) }
    end
    
    context "with incorrect coordinates" do
      let(:command) { "PLACE 6,2,SOUTH" }

      before { boltonizer.ask(command) }
      it { expect(boltonizer.response).to eq("Incorrect coordinates. Don't forget I am inside 5x5 grid!") }
    end
  end
  
  describe "MOVE" do
    it "moves correctly" do
      boltonizer.ask("PLACE 0,0,NORTH")

      boltonizer.ask("MOVE")
      expect(boltonizer.response).to eq("Done.")
      expect(boltonizer.coordinates.x).to eq(0)
      expect(boltonizer.coordinates.y).to eq(1)

      boltonizer.ask("MOVE")
      expect(boltonizer.response).to eq("Done.")
      expect(boltonizer.coordinates.x).to eq(0)
      expect(boltonizer.coordinates.y).to eq(2)
    end
    
    it "doesn't move outside table" do
      boltonizer.ask("PLACE 0,0,SOUTH")
      boltonizer.ask("MOVE")
      expect(boltonizer.response).to eq("Incorrect coordinates. Don't forget I am inside 5x5 grid!")
      expect(boltonizer.coordinates.x).to eq(0)
      expect(boltonizer.coordinates.y).to eq(0)
    end
  end
  
  describe "LEFT and RIGHT" do
    it "turns correctly" do
      boltonizer.ask("PLACE 0,0,SOUTH")

      boltonizer.ask("LEFT")
      expect(boltonizer.response).to eq("Done.")
      expect(boltonizer.coordinates.direction).to eq(:east)
      
      boltonizer.ask("LEFT")
      expect(boltonizer.coordinates.direction).to eq(:north)

      boltonizer.ask("LEFT")
      expect(boltonizer.coordinates.direction).to eq(:west)

      boltonizer.ask("LEFT")
      expect(boltonizer.coordinates.direction).to eq(:south)
      
      boltonizer.ask("RIGHT")
      expect(boltonizer.coordinates.direction).to eq(:west)
      
      boltonizer.ask("RIGHT")
      expect(boltonizer.coordinates.direction).to eq(:north)
      
      boltonizer.ask("RIGHT")
      expect(boltonizer.coordinates.direction).to eq(:east)
      
      boltonizer.ask("RIGHT")
      expect(boltonizer.coordinates.direction).to eq(:south)
    end
  end

  it "does nothing when not on the table" do
    boltonizer.ask("LEFT")
    expect(boltonizer.response).to eq("Please PLACE me on the table first.")
  end
  
  describe "REPORT" do
    it "reports current position" do
      boltonizer.ask("PLACE 1,2,WEST")
      boltonizer.ask("REPORT")
      
      expect(boltonizer.response).to eq("X: 1, Y: 2, direction: WEST")
    end
  end
  
  describe "Unknown command" do
    it "returns an error" do
      boltonizer.ask("HELLO 1,2,SOUTH")
      expect(boltonizer.response).to eq("Unknown command. Commands I understand: PLACE, MOVE, EXIT, LEFT, RIGHT, REPORT")

      boltonizer.ask("hi")
      expect(boltonizer.response).to eq("Unknown command. Commands I understand: PLACE, MOVE, EXIT, LEFT, RIGHT, REPORT")
      
      boltonizer.ask("PLACE")
      expect(boltonizer.response).to eq("Unknown command. Commands I understand: PLACE, MOVE, EXIT, LEFT, RIGHT, REPORT")
      
      boltonizer.ask("PLACE 1,b,SOUTH")
      expect(boltonizer.response).to eq("Unknown command. Commands I understand: PLACE, MOVE, EXIT, LEFT, RIGHT, REPORT")
      
      boltonizer.ask("PLACE 0,0,WHAT")
      expect(boltonizer.response).to eq("Unknown command. Commands I understand: PLACE, MOVE, EXIT, LEFT, RIGHT, REPORT")
    end
  end
end
