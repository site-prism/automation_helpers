# frozen_string_literal: true

describe Selenium::WebDriver::Logs do
  before { session.visit("/sample_page.html") }

  let(:session) { Capybara::Session.new(:selenium_chrome) }
  let(:log_message1) { instance_double(Selenium::WebDriver::LogEntry, 'Log One') }
  let(:log_message2) { instance_double(Selenium::WebDriver::LogEntry, 'Log Two') }

  before do
    allow_any_instance_of(Selenium::WebDriver::Chrome::Features)
      .to receive(:log)
      .with(type)
      .and_return([log_message1, log_message2])
    allow(session.driver.browser.logs)
      .to receive(:cached_logs)
      .and_call_original
  end

  describe "#log" do
    context "for browser logging" do
      let(:type) { :browser }

      it "caches the response from browser logs" do
        expect(session.driver.browser.logs).to receive(:cached_logs).once

        session.driver.browser.logs.get(type)
      end
    end
  end
end
