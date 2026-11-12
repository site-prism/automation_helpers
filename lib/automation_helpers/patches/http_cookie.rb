# frozen_string_literal: true

module AutomationHelpers
  module Patches
    #
    # Fix the issue where the `#expires=` writer method doesn't permit DateTime objects
    #
    class HTTPCookie < Base
      private

      def description
        <<~DESCRIPTION
          UPDATE: 12/11/2026
          This patch should in theory be redundant now since 2 additional features have been merged into
          the gem proper

          As such this patch is now considered a deprecated patch from the subsequent version (1.1.1), with a 2 year
          expiration date for removal

          ~~~~~~~~~~~~~~~~~~~~~

          ORIGINAL ISSUE:
          There is a bug/missing piece of functionality in the #expires= writer in HTTP::Cookie
          Selenium cookies (And by default w3c cookies), come with a DateTime class for the expiry

          See https://github.com/sparklemotion/http-cookie/pull/52 for more details about a potential extension.
        DESCRIPTION
      end

      def perform
        ::HTTP::Cookie.prepend HTTPCookiePatch
      end

      def deprecate_from
        '1.1.1'
      end

      def prevent_usage_date
        Time.new(2027, 9, 26)
      end

      def gem_version
        ::HTTP::Cookie::VERSION
      end
    end

    #
    # @api private
    #
    module HTTPCookiePatch
      # Permit DateTime objects to be cast in HTTP::Cookie
      def expires=(datetime)
        datetime = datetime.to_time if datetime.is_a?(DateTime)
        super
      end
    end
  end
end
