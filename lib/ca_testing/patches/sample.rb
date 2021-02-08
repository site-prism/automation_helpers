# frozen_string_literal: true

module CaTesting
  module Patches
    class Sample
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
          This is a sample patch. The file/class structure is here.
          We will remove this sample file once we have a couple of sample patches merged
        DESCRIPTION
      end

      def perform
        @changed_behaviour = :foo
      end

      def deprecate?
        Time.new > deprecation_notice_date
      end

      def deprecation_notice_date
        Time.new(2021, 2, 2)
      end

      def prevent_usage?
        Time.new > prevent_usage_date
      end

      def prevent_usage_date
        Time.new(2021, 5, 2)
      end
    end
  end
end
