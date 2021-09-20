# frozen_string_literal: true

module Selenium
  module WebDriver
    module Chrome
      module Features
        # @return [Hash]
        #
        # Perform the regular log fetch from Selenium, but then store the logs inside a Hash
        def log(type)
          cached_logs[type] = super
        end

        # @return [Integer]
        #
        # Write the logs to a filepath (If provided), or default file path (Configured).
        def write_log_to_file(type, file = default_file_path)
          log(type) unless cached_logs.key?(type)

          IO.write cached_logs[type], file
        end

        private

        def default_file_path
          CaTesting.chrome_log_path.tap { |path| raise "Path to log is missing" unless CaTesting.chrome_log_path }
        end

        def cached_logs
          @cached_logs ||= {}
        end
      end
    end
  end
end
