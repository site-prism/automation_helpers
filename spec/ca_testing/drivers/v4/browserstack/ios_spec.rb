# frozen_string_literal: true

RSpec.describe CaTesting::Drivers::V4::Browserstack::Ios do
  subject(:capabilities) { described_class.new(appium_version).capabilities }

  describe "#capabilities" do
    context "with a valid appium version" do
      let(:appium_version) { "12" }

      it "has correct ios capabilities" do
        expect(capabilities)
          .to eq(
            {
              "bstack:options" => {
                "deviceName" => "ios",
                "realMobile" => "true",
                "appiumVersion" => "1.19.1"
              }
            }
          )
      end

      context "with an invalid appium version" do
        let(:appium_version) { "10" }

        it "it complains ios version is invalid" do
          expect { capabilities }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
