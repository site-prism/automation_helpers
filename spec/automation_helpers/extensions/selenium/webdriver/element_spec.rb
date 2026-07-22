# frozen_string_literal: true

describe Selenium::WebDriver::Element do
  describe '#scroll_into_view' do
    let(:options) do
      AutomationHelpers::Drivers::V4::Options.for(:chrome).tap do |opts|
        opts.add_argument('--headless=new')
        opts.add_argument('--no-sandbox')
        opts.add_argument('--disable-dev-shm-usage')
      end
    end

    let(:driver) { Selenium::WebDriver.for(:chrome, options: options) }
    let(:page_path) { File.join(Dir.pwd, 'spec/support/fixtures', 'tall_page.html') }

    before do
      driver.get("file://#{page_path}")
    end

    def random_element_locator
      "cell-#{rand(1..50)}-#{rand(1..3)}"
    end

    it 'returns the original element (to aid chaining)' do
      element = driver.find_element(id: random_element_locator)

      expect(element.scroll_into_view).to eq(element)
    end

    it 'scrolls the element into the visible viewport' do
      locator = random_element_locator
      driver.find_element(id: locator).scroll_into_view
      visible = selenium_in_visible_viewport?(driver.find_element(id: locator))

      expect(visible).to be true
    end
  end
end
