# frozen_string_literal: true

module Selenium
  module WebDriver
    class Logs
      # @return [Hash]
      #
      # Perform the regular log fetch from Selenium, but then store the logs inside a Hash
      def get(type)
        cached_logs[type] = @bridge.log type
      end

      # @return [Integer]
      #
      # Write the logs to a filepath (If provided), or default file path (Configured).
      def write_log_to_file(type, file = default_file_path)
        get(type) unless cached_logs.key?(type)

        cached_logs[type].each do |log_entry|
          if file == $stdout
            file << log_entry
          else
            IO.write(file, log_entry)
          end
        end
      end

      private

      def default_file_path
        CaTesting.chrome_log_path.tap { |path| raise "Set the path to store logs using CaTesting.chrome_log_path=" unless path }
      end

      def cached_logs
        @cached_logs ||= {}
      end
    end
  end
end
