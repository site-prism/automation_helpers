# frozen_string_literal: true

RSpec.describe CaTesting::Drivers::V4::Capabilities do
  describe ".for" do
    subject(:capabilities) { described_class.for(browser, device_options).as_json }

    let(:device_options) { {} }

    context "for android" do
      let(:browser) { :android }

      context "with a valid device / android version" do
        let(:device_options) { { device_name: "SamsungGalaxyS20", os_version: "10" } }

        it "has correct android capabilities" do
          expect(capabilities).to eq(
            {
              "bstack:options" => {
                "deviceName" => "SamsungGalaxyS20",
                "realMobile" => "true",
                "appiumVersion" => "1.21.0"
              }
            }
          )
        end
      end

      context "with an invalid android version" do
        let(:device_options) { { device_name: "SamsungGalaxyS20", os_version: "8" } }

        it "it complains that the android version is invalid" do
          expect { capabilities }.to raise_error(ArgumentError)
        end
      end
    end

    context "for chrome" do
      let(:browser) { :chrome }

      it "has correct chrome capabilities" do
        expect(capabilities).to eq(
          {
            "browserName" => "chrome",
            "goog:loggingPrefs" => {
              "browser" => "ALL",
              "driver" => "ALL"
            }
          }
        )
      end
    end

    context "for internet_explorer" do
      let(:browser) { :internet_explorer }

      it "has correct chrome capabilities" do
        expect(capabilities).to eq(
          {
            "browserName" => "internet explorer",
            "bstack:options" => {
              "ie" => {
                "driver" => "3.141.59",
                "arch" => "x32"
              }
            }
          }
        )
      end
    end

    context "for ios" do
      let(:browser) { :ios }

      context "with a valid device / iOS version" do
        let(:device_options) { { device_name: "iPhone11", os_version: "12" } }

        it "has correct iOS capabilities" do
          expect(capabilities).to eq(
            {
              "bstack:options" => {
                "deviceName" => "iPhone11",
                "realMobile" => "true",
                "appiumVersion" => "1.20.2"
              }
            }
          )
        end
      end

      context "with an invalid iOS version" do
        let(:device_options) { { device_name: "iPhone11", os_version: "10" } }

        it "it complains that the iOS version is invalid" do
          expect { capabilities }.to raise_error(ArgumentError)
        end
      end
    end

    context "for any other browser" do
      let(:browser) { :foo }

      it { is_expected.to be_empty }
    end
  end
end
