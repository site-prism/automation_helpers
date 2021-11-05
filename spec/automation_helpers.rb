# frozen_string_literal: true

describe CaTesting do
  # Stop the $stdout process leaking cross-tests
  before { wipe_logger! }

  describe '.configure' do
    it 'can configure items in a configure block' do
      expect(described_class).to receive(:configure).once

      described_class.configure { |_| :foo }
    end

    it 'yields the configured options' do
      expect(described_class).to receive(:log_level=).with(:WARN)

      described_class.configure do |config|
        config.log_level = :WARN
      end
    end
  end

  describe '.logger' do
    context 'with default severity' do
      it 'does not log DEBUG messages' do
        log_messages = capture_stdout do
          described_class.logger.debug('DEBUG')
        end

        expect(log_messages).to be_empty
      end

      it 'logs UNKNOWN level messages' do
        log_messages = capture_stdout do
          described_class.logger.unknown('UNKNOWN')
        end

        expect(lines(log_messages)).to eq(1)
      end
    end

    context 'with an altered severity' do
      let(:log_messages) do
        capture_stdout do
          described_class.log_level = :DEBUG

          described_class.logger.debug('DEBUG')
          described_class.logger.info('INFO')
        end
      end

      it 'logs messages at all levels equal or above the new severity' do
        expect(lines(log_messages)).to eq(2)
      end
    end
  end

  describe '.logger=' do
    let(:existing_logger) { described_class.logger }

    context 'with a valid Logger input' do
      let(:new_logger) { ::Logger.new($stdout) }

      it 'sets the Logger to the new type' do
        expect { described_class.logger = new_logger }
          .to change { described_class.logger }
          .from(existing_logger)
          .to(new_logger)
      end
    end

    context 'with an invalid Logger input' do
      let(:new_logger) { :not_a_logger }

      it 'raises an ArgumentError' do
        expect { described_class.logger = new_logger }.to raise_error(ArgumentError)
      end
    end
  end

  describe '.log_path=' do
    context 'when set to a file' do
      let(:filename) { 'sample.log' }
      let(:file_content) { File.read(filename) }

      before { described_class.log_path = filename }

      after { File.delete(filename) if File.exist?(filename) }

      it 'sends the log messages to the file-path provided' do
        described_class.logger.unknown('This is sent to the file')

        expect(file_content).to end_with("This is sent to the file\n")
      end
    end

    context 'when set to $stderr' do
      it 'sends the log messages to $stderr' do
        expect do
          described_class.log_path = $stderr
          described_class.logger.unknown('This is sent to $stderr')
        end.to output(/This is sent to \$stderr/).to_stderr
      end
    end
  end

  describe '.log_level=' do
    it 'can alter the log level' do
      expect(described_class).to respond_to(:log_level=)
    end
  end

  describe '.log_level' do
    subject { described_class.log_level }

    it { is_expected.to eq(:INFO) }

    context 'when changed to `DEBUG`' do
      before { described_class.log_level = :DEBUG }

      it { is_expected.to eq(:DEBUG) }
    end
  end
end
