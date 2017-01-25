require "spec_helper"
require_relative "../../lib/command"

describe Command do
  describe "validation" do
    it { expect{ described_class.new("PLACE") }.to raise_exception(Command::Invalid) }
    # it { expect{ described_class.new("PLACE 1,b,SOUTH") }.to raise_exception(Command::Invalid) }
  end
end
