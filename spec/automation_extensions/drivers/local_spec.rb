# frozen_string_literal: true
RSpec.describe AutomationExtensions::Drivers::Local do
  it "Aliases the shorter context to the V4 namespace" do
    expect(described_class.new(double)).to be_a(AutomationExtensions::Drivers::V4::Local)
  end
end
