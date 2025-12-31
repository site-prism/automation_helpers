# frozen_string_literal: true

describe AutomationHelpers do
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
end
