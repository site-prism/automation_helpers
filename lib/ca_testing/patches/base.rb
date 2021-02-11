# frozen_string_literal: true

module CaTesting
  module Patches
    class Base
      #
      # api private (Not intended to be instantiated directly!)
      #
      def patch!
        raise "This is no longer supported" if prevent_usage?

        Kernel.warn("This is now deprecated and should not be used") if deprecate?
        CaTesting.logger.info("Adding patch: #{self.class}")
        CaTesting.logger.debug(description)
        perform
        CaTesting.logger.info("Patch successfully added.")
      end

      private

      def deprecate?
        Time.new > deprecation_notice_date
      end

      def prevent_usage?
        Time.new > prevent_usage_date
      end
    end
  end
end
