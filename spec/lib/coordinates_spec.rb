require "spec_helper"
require_relative "../../lib/coordinates"

describe Coordinates do
  describe "initialization" do
    it "sets x, y and direction" do
      coordinates = described_class.new("1", "2", "SOUTH")
      
      expect(coordinates.x).to eq(1)
      expect(coordinates.y).to eq(2)
      expect(coordinates.direction).to eq(:south)
    end
    
    it "raises exception when outside grid" do
      expect{ described_class.new("1", "6", "SOUTH") }.to raise_exception(Coordinates::OutsideTableError)
    end
  end
  
  describe ".directions_names" do
    it { expect(described_class.directions_names).to eq(["SOUTH", "NORTH", "WEST", "EAST"]) }
  end
  
  describe "move" do
    context "when direction is north" do
      let(:coordinates) { Coordinates.new(1, 2, "NORTH") }
      
      it "changes coordinates correctly" do
        coordinates.move
        expect(coordinates.x).to be(1)
        expect(coordinates.y).to be(3)
      end
      
      context "when direction is south" do
        let(:coordinates) { Coordinates.new(1, 2, "SOUTH") }
        
        it "changes coordinates correctly" do
          coordinates.move
          expect(coordinates.x).to be(1)
          expect(coordinates.y).to be(1)
        end
      end
      
      context "when direction is west" do
        let(:coordinates) { Coordinates.new(1, 2, "WEST") }
        
        it "changes coordinates correctly" do
          coordinates.move
          expect(coordinates.x).to be(0)
          expect(coordinates.y).to be(2)
        end
      end
      
      context "when direction is east" do
        let(:coordinates) { Coordinates.new(1, 2, "EAST") }
        
        it "changes coordinates correctly" do
          coordinates.move
          expect(coordinates.x).to be(2)
          expect(coordinates.y).to be(2)
        end
      end
      
      context "when outbound" do
        let(:coordinates) { Coordinates.new(1, 5, "NORTH") }
        
        it "changes coordinates correctly" do
          expect{ coordinates.move }.to raise_exception(Coordinates::OutsideTableError)
          expect(coordinates.x).to be(1)
          expect(coordinates.y).to be(5)
        end
      end
      
      describe "#left" do
        let(:coordinates) { described_class.new(1, 2, "SOUTH") }
        
        it "changes directions correctly" do
          expect{ coordinates.left }.to change{ coordinates.direction }.from(:south).to(:east)
          expect{ coordinates.left }.to change{ coordinates.direction }.from(:east).to(:north)
          expect{ coordinates.left }.to change{ coordinates.direction }.from(:north).to(:west)
          expect{ coordinates.left }.to change{ coordinates.direction }.from(:west).to(:south)
        end
      end
      
      describe "#right" do
        let(:coordinates) { described_class.new(1, 2, "SOUTH") }
        
        it "changes directions correctly" do
          expect{ coordinates.right }.to change{ coordinates.direction }.from(:south).to(:west)
          expect{ coordinates.right }.to change{ coordinates.direction }.from(:west).to(:north)
          expect{ coordinates.right }.to change{ coordinates.direction }.from(:north).to(:east)
          expect{ coordinates.right }.to change{ coordinates.direction }.from(:east).to(:south)
        end
      end
    end
  end
end
