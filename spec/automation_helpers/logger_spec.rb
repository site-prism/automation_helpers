# frozen_string_literal: true

describe CaTesting::Logger do
  describe "#create" do
    subject(:logger) { described_class.create }

    it { is_expected.to be_a Logger }

    it "has a default name" do
      expect(logger.progname).to eq("CA Testing Gem")
    end

    it "is turned off by default" do
      expect(logger.level).to eq(1)
    end
  end
end
