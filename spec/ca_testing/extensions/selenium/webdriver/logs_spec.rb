# frozen_string_literal: true

describe Selenium::WebDriver::Logs do
  let(:session) { Capybara::Session.new(:selenium_chrome) }

  before do
    allow(session.driver.browser.logs)
      .to receive(:cached_logs)
      .and_call_original
  end

  describe "#get" do
    context "for browser logging" do
      before do
        # This is the extended module on the Bridge that physically processes the log command
        allow(Selenium::WebDriver::Chrome::Features)
          .to receive(:log)
          .with(:browser)
          .and_return([browser_log, browser_log])
      end
      let(:type) { :browser }
      let(:browser_log) { instance_double(Selenium::WebDriver::LogEntry, to_s: "Time - SEV - Test Browser Log Message") }

      it "caches the response from browser logs" do
        expect(session.driver.browser.logs).to receive(:cached_logs).once

        session.driver.browser.logs.get(type)
      end
    end

    context "for driver logging" do
      before do
        # This is the extended module on the Bridge that physically processes the log command
        allow_any_instance_of(Selenium::WebDriver::Chrome::Features)
          .to receive(:log)
          .with(:driver)
          .and_return([driver_log, driver_log])
      end
      let(:type) { :driver }
      let(:driver_log) { instance_double(Selenium::WebDriver::LogEntry, to_s: "Time - SEV - Test Driver Log Message") }

      it "caches the response from browser logs" do
        expect(session.driver.browser.logs).to receive(:cached_logs).once

        session.driver.browser.logs.get(type)
      end
    end
  end
end
