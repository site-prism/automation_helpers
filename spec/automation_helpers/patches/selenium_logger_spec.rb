# frozen_string_literal: true

RSpec.describe AutomationHelpers::Patches::SeleniumLogger do
  it_behaves_like 'a patch' do
    before do
      skip 'Test will not pass on old selenium with semi-old capybara' if incompatible_capybara_and_selenium?
    end

    subject(:patch) { described_class.new }
  end
end
