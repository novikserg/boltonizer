require "spec_helper"
require_relative "../../lib/command"

describe Command do
  describe "#details?" do
    it "returns action coordinates for PLACE command" do
      command = described_class.new("PLACE 1,2,SOUTH")
      expect(command.details).to eq %w(1 2 SOUTH)
    end
  end

  describe ".ALLOWED_COMMANDS" do
    it { expect(described_class::ALLOWED_COMMANDS).to eq([:place, :move, :exit, :left, :right, :report]) }
  end
  
  describe ".formatted_allowed_commands" do
    it { expect(described_class.formatted_allowed_commands).to eq("PLACE, MOVE, EXIT, LEFT, RIGHT, REPORT") }
  end
  
  describe "#place?" do
    subject { command.place? }

    context "for place command" do
      let(:command) { described_class.new("PLACE 1,2,SOUTH") }
      it { is_expected.to be_truthy }
    end

    context "for other command" do
      let(:command) { described_class.new("MOVE") }
      it { is_expected.to be_falsey }
    end
  end
  
  describe "#exit?" do
    subject { command.exit? }

    context "for exit command" do
      let(:command) { described_class.new("EXIT") }
      it { is_expected.to be_truthy }
    end

    context "for other command" do
      let(:command) { described_class.new("MOVE") }
      it { is_expected.to be_falsey }
    end
  end

  describe "#command_name" do
    it "extracts and symbolizes the command name" do
      subject = Proc.new{ |command| described_class.new(command).command_name }
      
      expect(subject.call("PLACE 1,2,SOUTH")).to eq(:place)
      expect(subject.call("MOVE")).to            eq(:move)
      expect(subject.call("LEFT")).to            eq(:left)
      expect(subject.call("RIGHT")).to           eq(:right)
      expect(subject.call("EXIT")).to            eq(:exit)
      expect(subject.call("REPORT")).to          eq(:report)
    end
  end
  
  describe "initialization" do
    def new_command(command)
      described_class.new(command)
    end

    context "for invalid commands" do
      it "raises exception for invalid commands" do
        expect{ new_command("hi") }.to               raise_exception(Command::Invalid)
        expect{ new_command("PLACE 10,2,SOUTH") }.to raise_exception(Command::Invalid)
        expect{ new_command("PLACE 1,2") }.to        raise_exception(Command::Invalid)
        expect{ new_command("PLACE") }.to            raise_exception(Command::Invalid)
      end
    end

    context "for valid commands" do
      it "passes" do
        expect{ new_command("PLACE 1,2,SOUTH") }.not_to raise_exception
        expect{ new_command("MOVE")            }.not_to raise_exception
        expect{ new_command("LEFT")            }.not_to raise_exception
        expect{ new_command("RIGHT")           }.not_to raise_exception
        expect{ new_command("EXIT")            }.not_to raise_exception
        expect{ new_command("REPORT")          }.not_to raise_exception
      end
    end
  end
end
