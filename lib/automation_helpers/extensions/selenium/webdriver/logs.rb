# frozen_string_literal: true

module Selenium
  module WebDriver
    #
    # Additional useful methods to extend the Selenium::WebDriver::Logs class with
    #
    class Logs
      # @return [Array]
      #
      # Identical to the regular log fetch from Selenium, but accumulates the logs inside a Hash to be writable later.
      # Selenium only returns entries logged since the previous fetch, so each call adds to what is already stored
      def get(type)
        (cached_logs[type] ||= []).concat(@bridge.log(type))
      end

      # @return [Integer]
      #
      # Write the logs for this type (See #write_all_logs_to_file)
      def write_log_to_file(type, file = default_file_path)
        write_all_logs_to_file(file, types: [type])
      end

      # @return [Integer]
      #
      # Fetch any outstanding logs, then write everything accumulated for each type (Browser and Driver by default)
      # to a filepath (If provided), or default file path (Configured). If the file already has content, the logs
      # are appended on a new line rather than overwriting it. Written logs are cleared, so are never written twice.
      # Returns the number of bytes written as per the regular Ruby Filesystem method
      def write_all_logs_to_file(file = default_file_path, types: %i[browser driver])
        content = types.flat_map { |type| get(type) && cached_logs.delete(type) }.join("\n")
        return 0 if content.empty?
        return file << content if file == $stdout

        content = "\n#{content}" if File.size?(file)
        File.write(file, content, mode: 'a')
      end

      private

      def default_file_path
        AutomationHelpers.chrome_log_path || raise(missing_file_path_error)
      end

      def cached_logs
        @cached_logs ||= {}
      end

      def missing_file_path_error
        'Set the path to store logs using AutomationHelpers.chrome_log_path= or pass in a filepath directly to #write_log_to_file'
      end
    end
  end
end
