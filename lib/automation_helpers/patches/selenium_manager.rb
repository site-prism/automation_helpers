# frozen_string_literal: true

module AutomationHelpers
  module Patches
    class SeleniumManager < Base
      private

      def description
        <<~DESCRIPTION
          This patch fixes an issue with Selenium4 not bubbling up the httpOnly property of a cookie
          See: https://github.com/SeleniumHQ/selenium/pull/8958 for more details/discussion including this fix
        DESCRIPTION
      end

      def perform
        ::Selenium::WebDriver::Manager.prepend CookieConverter
      end

      def deprecate_from
        '4.0.0.beta3'
      end

      def prevent_usage_from
        '4.0.0'
      end

      def gem_version
        ::Selenium::WebDriver::VERSION
      end
    end

    module CookieConverter
      def convert_cookie(cookie)
        super(cookie)
          .merge(
            {
              http_only: cookie['httpOnly']
            }
          )
      end
    end
  end
end
