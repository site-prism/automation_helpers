# frozen_string_literal: true

describe Capybara::Node::Element do
  subject(:capybara_element) { session.find('.embedded_element') }

  before do
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

  describe '#scroll_into_view' do
    let(:options) do
      AutomationHelpers::Drivers::V4::Options.for(:chrome).tap do |opts|
        opts.add_argument('--no-sandbox')
        opts.add_argument('--disable-dev-shm-usage')
      end
    end

    before do
      AutomationHelpers::Drivers::Local.new(:chrome, options).register
      Capybara.default_driver = :selenium
      Capybara.current_session.visit('/tall_page.html')
    end

    def random_element_locator
      "#cell-#{rand(1..50)}-#{rand(1..3)}"
    end

    it 'returns the original element (to aid chaining)' do
      element = Capybara.current_session.find(random_element_locator)

      expect(element.scroll_into_view).to eq(element)
    end

    it 'scrolls the element into the visible viewport' do
      locator = random_element_locator
      Capybara.current_session.find(locator).scroll_into_view
      visible = capybara_in_visible_viewport?(Capybara.current_session.find(locator, wait: 2))

      expect(visible).to be true
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
