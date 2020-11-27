# frozen_string_literal: true
RSpec.describe AutomationExtensions::Drivers::V4::Options do
  describe "#options" do
    subject { described_class.new(browser).options }

    context "for chrome" do
      let(:browser) { :chrome }

      it "returns the correct v4 compliant options" do
        expect(subject).to eq({})
      end
    end

    context "for firefox" do
      let(:browser) { :firefox }

      it "returns the correct v4 compliant options" do
        expect(subject).to eq({})
      end
    end

    context "for internet explorer" do
      let(:browser) { :internet_explorer }

      it "returns the correct v4 compliant options" do
        expect(subject).to eq({})
      end
    end

    context "for safari" do
      let(:browser) { :safari }

      it "returns the correct v4 compliant options" do
        expect(subject).to eq({})
      end
    end

    context "for ios" do
      let(:browser) { :ios }

      it "returns the correct v4 compliant options" do
        expect(subject).to eq({})
      end
    end
  end
end
