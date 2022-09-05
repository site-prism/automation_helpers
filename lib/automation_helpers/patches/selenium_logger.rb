# frozen_string_literal: true

module AutomationHelpers
  module Patches
    #
    # Fix the issue where the Selenium Logger isn't designed to parse characters that aren't standard ASCII
    # (This is an issue in the parent Net-HTTP adapter that most loggers are built on)
    #
    class SeleniumLogger < Base
      private

      def description
        <<~DESCRIPTION
          When using the Selenium Logger that is set to pipe to a file, the Net::HTTP adapter (default),
          can return unencoded binary (confusingly called ASCII-8BIT in Ruby).
          Consequently we set the logger to binmode so it doesn't try to encode the data - this would always
          cause errors for non-ASCII characters, whatever the parent encoding is. An example of this is ©.

          See https://github.com/ruby/net-http/issues/14 for a root cause analysis of the Adapter
        DESCRIPTION
      end

      def perform
        ::Selenium::WebDriver.logger.io.binmode
      end
    end
  end
end
