# frozen_string_literal: true

RSpec.describe CaTesting::Drivers::V4::Browserstack::Android do
  subject(:capabilities) { described_class.new.capabilities }

  describe "#capabilities" do
    it "has correct android capabilities" do
      expect(capabilities)
        .to eq(
          {
            "bstack:options" => {
               "osVersion" => "10.0",
               "deviceName" => "Samsung Galaxy S20",
               "realMobile" => "true",
               "appiumVersion" => "1.17.0"
            }
          }
        )
    end
  end
end
