# frozen_string_literal: true

module Selenium
  module WebDriver
    class Logs
      # @return [Hash]
      #
      # Identical to the regular log fetch from Selenium, but stores the logs inside a Hash to be writable later
      def get(type)
        cached_logs[type] = @bridge.log(type)
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
        CaTesting.chrome_log_path || raise(missing_file_path_error)
      end

      def cached_logs
        @cached_logs ||= {}
      end

      def missing_file_path_error
        "Set the path to store logs using CaTesting.chrome_log_path= or pass in a filepath directly to #write_log_to_file"
      end
    end
  end
end
