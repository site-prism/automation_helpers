# frozen_string_literal: true
RSpec.describe CaTesting::Patches::Logger do
  it_behaves_like "a patch" do
    subject { described_class.new(double) }
  end
end
