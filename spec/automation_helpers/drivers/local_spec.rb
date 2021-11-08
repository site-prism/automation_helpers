# frozen_string_literal: true

RSpec.describe AutomationHelpers::Drivers::Local do
  it 'aliases the shorter context to the V4 namespace' do
    expect(described_class.new(double)).to be_a(AutomationHelpers::Drivers::V4::Local)
  end
end
