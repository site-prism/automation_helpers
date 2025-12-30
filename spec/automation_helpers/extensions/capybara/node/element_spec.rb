# frozen_string_literal: true

describe Capybara::Node::Element do
  subject(:capybara_element) { session.find('.embedded_element') }

  before do
    skip 'Test will not pass on old selenium with semi-old capybara' if legacy_capybara?
    session.visit('/sample_page.html')
  end

  let(:session) { capybara_session }

  describe '#horizontal_position' do
    it 'returns the top-left horizontal ordinate from the native rect' do
      expect(capybara_element.horizontal_position).to eq(8)
    end
  end

  describe '#vertical_position' do
    it 'returns the top-left vertical ordinate from the native rect' do
      expect(capybara_element.vertical_position).to eq(169)
    end
  end

  describe '#stale?' do
    context 'when not stale' do
      it { is_expected.not_to be_stale }
    end

    context 'when made stale' do
      it 'returns true' do
        cached_element = capybara_element
        session.find_by_id('remove_container').click

        expect(cached_element).to be_stale
      end
    end
  end
end
