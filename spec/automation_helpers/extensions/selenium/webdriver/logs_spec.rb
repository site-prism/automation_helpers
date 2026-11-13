# frozen_string_literal: true

describe Selenium::WebDriver::Logs do
  # The Bridge is considered API Private, but we need to mock it!
  let(:bridge) { logs.instance_variable_get(:@bridge) }
  let(:log_entry) { instance_double(Selenium::WebDriver::LogEntry, to_s: 'Time - SEV - Browser or Driver Message') }
  let(:logs) { capybara_session.driver.browser.logs }
  let(:file) { Tempfile.new('foo') }

  def stub_entry(message)
    instance_double(Selenium::WebDriver::LogEntry, to_s: message)
  end

  before do
    allow(bridge).to receive(:log).with(type).and_return([log_entry])
  end

  context 'when logging browser messages' do
    let(:type) { :browser }

    describe '#get' do
      it 'stores the response from browser logs' do
        expect { logs.get(type) }.to change(logs, :cached_logs).from({}).to(a_hash_including(type))
      end
    end

    describe '#write_log_to_file' do
      after do
        AutomationHelpers.chrome_log_path = nil
        file.close!
      end

      it 'writes the log messages to a filepath' do
        logs.write_log_to_file(type, file.path)

        expect(file.read).to eq(log_entry.to_s)
      end

      it 'creates the file when it does not exist' do
        Dir.mktmpdir do |dir|
          path = File.join(dir, 'new_log.txt')

          logs.write_log_to_file(type, path)

          expect(File.read(path)).to eq(log_entry.to_s)
        end
      end

      it 'appends the log messages to a file that already has content' do
        File.write(file.path, 'Existing line')

        logs.write_log_to_file(type, file.path)

        expect(file.read).to eq("Existing line\n#{log_entry}")
      end

      it 'writes every log message to a filepath, one per line' do
        allow(bridge).to receive(:log).with(type).and_return([log_entry, log_entry])

        logs.write_log_to_file(type, file.path)

        expect(file.read).to eq("#{log_entry}\n#{log_entry}")
      end

      it 'writes the log messages to $stdout' do
        console_output = capture_stdout do
          logs.write_log_to_file(type, $stdout)
        end

        expect(console_output).to eq(log_entry.to_s)
      end

      it 'uses the configured filepath from chrome_log_path' do
        AutomationHelpers.chrome_log_path = file.path

        expect { logs.write_log_to_file(type) }.not_to raise_error
      end

      it 'raises an error when there is no configured filepath' do
        expect { logs.write_log_to_file(type) }.to raise_error(RuntimeError)
      end
    end
  end

  context 'when logging driver messages' do
    let(:type) { :driver }

    describe '#get' do
      it 'stores the response from browser logs' do
        expect { logs.get(type) }.to change(logs, :cached_logs).from({}).to(a_hash_including(type))
      end
    end

    describe '#write_log_to_file' do
      after do
        AutomationHelpers.chrome_log_path = nil
        file.close!
      end

      it 'writes the log messages to a filepath' do
        logs.write_log_to_file(type, file.path)

        expect(file.read).to eq(log_entry.to_s)
      end

      it 'creates the file when it does not exist' do
        Dir.mktmpdir do |dir|
          path = File.join(dir, 'new_log.txt')

          logs.write_log_to_file(type, path)

          expect(File.read(path)).to eq(log_entry.to_s)
        end
      end

      it 'appends the log messages to a file that already has content' do
        File.write(file.path, 'Existing line')

        logs.write_log_to_file(type, file.path)

        expect(file.read).to eq("Existing line\n#{log_entry}")
      end

      it 'writes every log message to a filepath, one per line' do
        allow(bridge).to receive(:log).with(type).and_return([log_entry, log_entry])

        logs.write_log_to_file(type, file.path)

        expect(file.read).to eq("#{log_entry}\n#{log_entry}")
      end

      it 'writes the log messages to $stdout' do
        console_output = capture_stdout do
          logs.write_log_to_file(type, $stdout)
        end

        expect(console_output).to eq(log_entry.to_s)
      end

      it 'uses the configured filepath from chrome_log_path' do
        AutomationHelpers.chrome_log_path = file.path

        expect { logs.write_log_to_file(type) }.not_to raise_error
      end

      it 'raises an error when there is no configured filepath' do
        expect { logs.write_log_to_file(type) }.to raise_error(RuntimeError)
      end
    end
  end

  context 'when logs are captured across multiple fetches' do
    let(:type) { :browser }

    def batches
      @batches ||= [[stub_entry('First')], [stub_entry('Second')]]
    end

    after { file.close! }

    it 'accumulates the logs from every #get call' do
      allow(bridge).to receive(:log).with(type).and_return(*batches)

      2.times { logs.get(type) }

      expect(logs.send(:cached_logs)[type]).to eq(batches.flatten)
    end

    it 'writes both the previously fetched and the outstanding logs' do
      allow(bridge).to receive(:log).with(type).and_return(*batches)

      logs.get(type)
      logs.write_log_to_file(type, file.path)

      expect(File.read(file.path)).to eq("First\nSecond")
    end

    it 'does not write the same logs twice' do
      allow(bridge).to receive(:log).with(type).and_return(*batches)

      2.times { logs.write_log_to_file(type, file.path) }

      expect(File.read(file.path)).to eq("First\nSecond")
    end

    it 'writes nothing when there are no logs' do
      allow(bridge).to receive(:log).with(type).and_return([])

      expect(logs.write_log_to_file(type, file.path)).to eq(0)
    end
  end

  describe '#write_all_logs_to_file' do
    let(:type) { :browser }

    before do
      allow(bridge).to receive(:log).with(:browser).and_return([stub_entry('Browser message')])
      allow(bridge).to receive(:log).with(:driver).and_return([stub_entry('Driver message')])
    end

    after do
      AutomationHelpers.chrome_log_path = nil
      file.close!
    end

    it 'writes the browser and driver logs to a single file' do
      logs.write_all_logs_to_file(file.path)

      expect(File.read(file.path)).to eq("Browser message\nDriver message")
    end

    it 'appends to a file that already has content' do
      File.write(file.path, 'Existing line')

      logs.write_all_logs_to_file(file.path)

      expect(File.read(file.path)).to eq("Existing line\nBrowser message\nDriver message")
    end

    it 'only writes the requested types' do
      logs.write_all_logs_to_file(file.path, types: [:driver])

      expect(File.read(file.path)).to eq('Driver message')
    end

    it 'writes the logs to $stdout' do
      console_output = capture_stdout { logs.write_all_logs_to_file($stdout) }

      expect(console_output).to eq("Browser message\nDriver message")
    end

    it 'uses the configured filepath from chrome_log_path' do
      AutomationHelpers.chrome_log_path = file.path

      logs.write_all_logs_to_file

      expect(File.read(file.path)).to eq("Browser message\nDriver message")
    end

    it 'raises an error when there is no configured filepath' do
      expect { logs.write_all_logs_to_file }.to raise_error(RuntimeError)
    end
  end
end
