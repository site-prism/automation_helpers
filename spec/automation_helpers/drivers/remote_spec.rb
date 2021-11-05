# frozen_string_literal: true

RSpec.describe CaTesting::Drivers::Remote do
  it 'aliases the shorter context to the V4 namespace' do
    expect(described_class.new(double)).to be_a(CaTesting::Drivers::V4::Remote)
  end
end
