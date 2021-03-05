# frozen_string_literal: true

module CaTesting
  module Patches
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

      def deprecate?
        false
      end
    end
  end
end
