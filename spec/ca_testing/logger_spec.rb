# frozen_string_literal: true

describe CaTesting::Logger do
  describe "#create" do
    subject(:logger) { described_class.new.create }

    it { is_expected.to be_a Logger }

    it "has a default name" do
      expect(logger.progname).to eq("CA Testing Gem")
    end

    it "has a default logging level" do
      expect(logger.level).to eq(5)
    end
  end
end
