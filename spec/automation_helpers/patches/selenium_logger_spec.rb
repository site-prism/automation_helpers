# frozen_string_literal: true

RSpec.describe AutomationHelpers::Patches::SeleniumLogger do
  it_behaves_like 'a patch' do
    subject(:patch) { described_class.new }
  end
end
