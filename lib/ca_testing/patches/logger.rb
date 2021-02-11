# frozen_string_literal: true

module CaTesting
  module Patches
    class Logger
      def patch!
        raise "This is no longer supported" if prevent_usage?

        Kernel.warn("This is now deprecated and should not be used") if deprecate?
        CaTesting.logger.info("Adding patch: #{self.class}")
        CaTesting.logger.debug(description)
        perform
        CaTesting.logger.info("Patch successfully added.")
      end

      private

      def description
        <<~DESCRIPTION
          This enables any Logger to convert it's encoding to one which supports special characters.
          Examples of this are things like © which use the ASCII encoding protocol (Instead of UTF-8).
        DESCRIPTION
      end

      def perform
        :change_some_behaviour
      end

      def deprecate?
        Time.new > deprecation_notice_date
      end

      def deprecation_notice_date
        Time.new(2022, 1, 1)
      end

      def prevent_usage?
        Time.new > prevent_usage_date
      end

      def prevent_usage_date
        Time.new(3000, 1, 1)
      end
    end
  end
end
