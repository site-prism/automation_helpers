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
          There is a bug/missing piece of functionality in the #expires= writer in HTTP::Cookie
          Selenium cookies (And by default w3c cookies), come with a DateTime class for the expiry

          See https://github.com/sparklemotion/http-cookie/pull/52 for more details about a potential extension.
        DESCRIPTION
      end

      def perform
        ::HTTP::Cookie.prepend HTTPCookiePatch
      end
    end

    #
    # @api private
    #
    module HTTPCookiePatch
      # Permit DateTime objects to be casted in HTTP::Cookie
      def expires=(datetime)
        datetime = datetime.to_time if datetime.is_a?(DateTime)
        super
      end
    end
  end
end
