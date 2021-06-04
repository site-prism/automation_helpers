# frozen_string_literal: true

RSpec.describe CaTesting::Drivers::V4::Browserstack::Chrome do
  subject(:capabilities) { described_class.new.capabilities }

  describe "#capabilities" do
    it "has correct chrome capabilities" do
      expect(capabilities)
        .to eq(
          {
            "goog:loggingPrefs" => {
              browser: "ALL",
              driver: "ALL"
            }
          }
        )
    end
  end
end
