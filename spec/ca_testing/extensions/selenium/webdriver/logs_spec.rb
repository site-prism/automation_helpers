# frozen_string_literal: true

describe Selenium::WebDriver::Logs do
  # The Bridge is considered API Private, but we need to mock it!
  let(:bridge) { session.driver.browser.logs.instance_variable_get(:@bridge) }
  let(:log_entry) { instance_double(Selenium::WebDriver::LogEntry, to_s: "Time - SEV - Browser or Driver Message") }
  let(:session) { Capybara::Session.new(:selenium_chrome_headless) }
  let(:logs) { session.driver.browser.logs }
  before do
    allow(bridge)
      .to receive(:log)
      .with(type)
      .and_return([log_entry])

    allow(session.driver.browser.logs)
      .to receive(:cached_logs)
      .and_call_original
  end

  context "for browser logging" do
    let(:type) { :browser }

    describe "#get" do
      it "caches the response from browser logs" do
        expect(logs).to receive(:cached_logs).once

        logs.get(type)
      end
    end

    describe "#write_log_to_file" do
      after do
        file.close
        file.unlink
      end

      let(:file) { Tempfile.new("foo") }

      it "writes the log messages to a filepath" do
        logs.write_log_to_file(type, file.path)

        expect(file.read).to eq(log_entry.to_s)
      end

      it "writes the log messages to $stdout" do
        console_output = capture_stdout do
          logs.write_log_to_file(type, $stdout)
        end

        expect(console_output).to eq(log_entry.to_s)
      end

      context "with no filepath specified" do
        after { CaTesting.chrome_log_path = nil }

        it "uses the configured filepath from chrome_log_path" do
          CaTesting.chrome_log_path = file.path

          expect { logs.write_log_to_file(type, file.path) }.not_to raise_error
        end

        it "raises an error when there is no configured filepath" do
          expect { logs.write_log_to_file(type) }.to raise_error(RuntimeError)
        end
      end
    end
  end

  context "for driver logging" do
    let(:type) { :driver }

    describe "#get" do
      it "caches the response from browser logs" do
        expect(logs).to receive(:cached_logs).once

        logs.get(type)
      end
    end

    describe "#write_log_to_file" do
      after do
        file.close
        file.unlink
      end

      let(:file) { Tempfile.new("foo") }

      it "writes the log messages to a filepath" do
        logs.write_log_to_file(type, file.path)

        expect(file.read).to eq(log_entry.to_s)
      end

      it "writes the log messages to $stdout" do
        console_output = capture_stdout do
          logs.write_log_to_file(type, $stdout)
        end

        expect(console_output).to eq(log_entry.to_s)
      end

      context "with no filepath specified" do
        after { CaTesting.chrome_log_path = nil }

        it "uses the configured filepath from chrome_log_path" do
          CaTesting.chrome_log_path = file.path

          expect { logs.write_log_to_file(type, file.path) }.not_to raise_error
        end

        it "raises an error when there is no configured filepath" do
          expect { logs.write_log_to_file(type) }.to raise_error(RuntimeError)
        end
      end
    end
  end
end
