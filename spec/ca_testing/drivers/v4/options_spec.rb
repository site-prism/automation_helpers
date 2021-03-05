# frozen_string_literal: true

RSpec.describe CaTesting::Drivers::V4::Options do
  describe "#options" do
    subject(:options) { described_class.new(browser).options }

    context "for chrome" do
      let(:browser) { :chrome }

      it { is_expected.to have_attributes({ browser_name: "chrome" }) }
    end

    context "for firefox" do
      let(:browser) { :firefox }

      it { is_expected.to have_attributes({ browser_name: "firefox", log: { level: "trace" } }) }
    end

    context "for internet explorer" do
      let(:browser) { :internet_explorer }

      it { is_expected.to have_attributes({ native_events: true, persistent_hover: true }) }
    end

    context "for safari" do
      let(:browser) { :safari }

      it { is_expected.to have_attributes({ browser_name: "safari", automatic_inspection: true }) }
    end

    context "for ios" do
      let(:browser) { :ios }

      it { is_expected.to be_empty }
    end

    context "for android" do
      let(:browser) { :android }

      it { is_expected.to be_empty }
    end

    context "for an unsupported browser" do
      let(:browser) { :foo }

      it "doesn't work if the browser is not one of the supported browsers" do
        expect { subject }.to raise_error(NoMethodError)
      end
    end
  end
end
