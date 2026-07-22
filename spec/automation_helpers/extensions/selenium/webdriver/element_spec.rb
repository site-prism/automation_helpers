# frozen_string_literal: true

describe Selenium::WebDriver::Element do
  describe '#scroll_into_view' do
    let(:driver) { Selenium::WebDriver.for(:chrome) }
    let(:page_path) { File.join(Dir.pwd, "spec/support/fixtures", "tall_page.html") }

    before do
      driver.get("file://#{page_path}")
    end

    def random_element
      driver.find_element(id: "cell-#{rand(1..50)}-#{rand(1..3)}")
    end

    it 'returns the original element (to aid chaining)' do
      element = random_element

      expect(element.scroll_into_view).to eq(element)
    end

    it 'scrolls the element into the visible viewport' do
      element = random_element
      element.scroll_into_view
      visible = selenium_in_visible_viewport?(element)

      expect(visible).to be true
    end
  end
end
