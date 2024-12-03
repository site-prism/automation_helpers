# frozen_string_literal: true

RSpec.describe AutomationHelpers::Patches::SeleniumLogger do
  it_behaves_like 'a patch' do
    subject(:patch) { described_class.new }

    before do
      skip 'Test will not pass on old selenium with semi-old capybara' if incompatible_capybara_and_selenium_versions?
    end
  end
end
