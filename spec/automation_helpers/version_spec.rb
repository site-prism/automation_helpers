# frozen_string_literal: true

RSpec.describe 'Gem Version' do
  it 'has a version number' do
    expect(AutomationHelpers::VERSION).not_to be_nil
  end
end
