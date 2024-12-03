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
          UPDATE: 3/12/2024
          This patch should in theory be redundant now the root cause has been identified as a processing
          debugger fault in RubyMine. Since Ruby 3.2 this should no longer be an issue providing you are
          using an "up-to-date" RubyMine. I personally haven't encountered this issue for a couple of years

          As such this patch is now considered a deprecated patch with a 1 year TTL, at which point we'll then
          consider it for removal from the gem proper

          ~~~~~~~~~~~~~~~~~~~~~

          ORIGINAL ISSUE:
          When using the Selenium Logger that is set to pipe to a file, the Net::HTTP adapter (default),
          can return unencoded binary (confusingly called ASCII-8BIT in Ruby).
          Consequently we set the logger to binmode so it doesn't try to encode the data - this would always
          cause errors for non-ASCII characters, whatever the parent encoding is. An example of this is ©.

          See https://github.com/ruby/net-http/issues/14 for a root cause analysis of the Adapter
        DESCRIPTION
      end

      def deprecation_notice_date
        Time.new(2025, 12, 3)
      end

      def prevent_usage_date
        Time.new(2026, 12, 3)
      end

      def perform
        ::Selenium::WebDriver.logger.io.binmode
      end
    end
  end
end
