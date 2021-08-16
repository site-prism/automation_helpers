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

      #
      # api private (Not intended to be instantiated directly!)
      #
      # From what point should this patch start throwing deprecation notices
      # If a date is provided, then after that date
      # If a version from is provided, then all releases after that one (NB: You must provide a link to the gem version)
      #
      def deprecate?
        if defined?(deprecation_notice_date)
          Time.new >= deprecation_notice_date
        elsif defined?(deprecate_from)
          Gem::Version.new(gem_version) >= Gem::Version.new(deprecate_from)
        end
      end

      #
      # api private (Not intended to be instantiated directly!)
      #
      # From what point should this patch start preventing usage deprecation notices
      # If a date is provided, then after that date
      # If a version from is provided, then all releases after that one (NB: You must provide a link to the gem version)
      #
      def prevent_usage?
        if defined?(prevent_usage_date)
          Time.new >= prevent_usage_date
        elsif defined?(prevent_usage_from)
          Gem::Version.new(gem_version) >= Gem::Version.new(prevent_usage_from)
        end
      end
    end
  end
end
