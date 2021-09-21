# frozen_string_literal: true

describe Selenium::WebDriver::Logs do
  let(:session) { Capybara::Session.new(:selenium_chrome) }
  let(:filepath) { $stdout }
  let(:log_entry) { instance_double(Selenium::WebDriver::LogEntry, to_s: "Time - SEV - Browser or Driver Message") }

  before do
    # This is the extended module on the Bridge that physically processes the log command
    allow_any_instance_of(Selenium::WebDriver::Chrome::Features)
      .to receive(:log)
      .with(type)
      .and_return([log_entry, log_entry])

    allow(session.driver.browser.logs)
      .to receive(:cached_logs)
      .and_call_original
  end

  context "for browser logging" do
    let(:type) { :browser }

    describe "#get" do
      it "caches the response from browser logs" do
        expect(session.driver.browser.logs).to receive(:cached_logs).once

        session.driver.browser.logs.get(type)
      end
    end

    describe "#write_log_to_file" do
      it "writes the log messages to a filepath" do
        log_messages = capture_stdout do
          session.driver.browser.logs.write_log_to_file(type, filepath)
        end

        expect(log_messages).to be_empty
      end
    end
  end

  context "for driver logging" do
    let(:type) { :driver }

    describe "#get" do
      it "caches the response from browser logs" do
        expect(session.driver.browser.logs).to receive(:cached_logs).once

        session.driver.browser.logs.get(type)
      end
    end

    describe "#write_log_to_file" do
      it "writes the log messages to a filepath" do
        log_messages = capture_stdout do
          session.driver.browser.logs.write_log_to_file(type, filepath)
        end

        expect(log_messages).to be_empty
      end
    end
  end
end
