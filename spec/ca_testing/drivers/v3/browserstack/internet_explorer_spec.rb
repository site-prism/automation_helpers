# frozen_string_literal: true

RSpec.describe CaTesting::Drivers::V3::Browserstack::InternetExplorer do
  subject(:capabilities) { described_class.new.capabilities }

  describe "#capabilities" do
    it "has correct internet explorer capabilities" do
      expect(capabilities)
        .to eq(
          {
            "browserName" => "internet explorer",
            "bstack:options" => {
              "ie" => {
                "driver" => "3.141.59",
                "arch" => "x32"
            }
          }
        )
    end
  end
end
