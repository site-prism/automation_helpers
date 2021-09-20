# frozen_string_literal: true

describe Selenium::WebDriver::DriverExtensions::HasLogs do
  before { session.visit("/sample_page.html") }

  let(:session) { Capybara::Session.new(:selenium_chrome) }
  let(:type) { :browser }

  before do
    allow_any_instance_of(Selenium::WebDriver::Logs).to receive(:get).with(type).and_return([:jeff1, :jeff2])
  end

  describe "#log" do
    it "returns the top-left horizontal ordinate from the native rect" do
      expect(session.driver.browser.logs.get(type)).to be true
    end
  end

  describe "#stale?" do
    context "when not stale" do
      it { is_expected.not_to be_stale }
    end

    context "when made stale" do
      it "returns true" do
        cached_element = capybara_element
        session.find("#remove_container").click

        expect(cached_element).to be_stale
      end
    end
  end
end
