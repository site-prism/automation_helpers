# frozen_string_literal: true

RSpec.describe CaTesting::Drivers::V4::Browserstack::Ios do
  subject(:capabilities) { described_class.new(device_name, ios_version).capabilities }

  let(:ios_version) { "12" }
  let(:device_name) { "iPhone11" }

  describe "#capabilities" do
    context "with a valid device / iOS version" do
      it "has correct ios capabilities" do
        expect(capabilities).to eq(
          {
            "bstack:options" => {
              "deviceName" => "iPhone11",
              "realMobile" => "true",
              "appiumVersion" => "1.19.1"
            }
          }
        )
      end
    end

    context "with an invalid iOS version" do
      let(:ios_version) { "10" }

      it "it complains that the iOS version is invalid" do
        expect { capabilities }.to raise_error(ArgumentError)
      end
    end
  end
end
