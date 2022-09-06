# frozen_string_literal: true

RSpec.describe AutomationHelpers::Patches::SeleniumOptions do
  context 'with firefox' do
    it_behaves_like 'a patch' do
      subject(:patch) { described_class.new(:firefox) }
    end
  end

  context 'with safari' do
    it_behaves_like 'a patch' do
      subject(:patch) { described_class.new(:safari) }
    end
  end

  context 'with anything else' do
    subject(:patch) { described_class.new(:foo) }

    it 'does not perform the patch' do
      expect(AutomationHelpers.logger).not_to receive(:info).with(/Adding patch/)

      patch.patch!
    end
  end
end
