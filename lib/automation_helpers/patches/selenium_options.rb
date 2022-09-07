# frozen_string_literal: true

module AutomationHelpers
  module Patches
    #
    # Fix the issue where for some drivers selenium doesn't camelize the browser name key 'browserName' correctly
    #
    class SeleniumOptions < Base
      def initialize(browser)
        @browser = browser
        super()
      end

      # @return [nil || true]
      #
      # For SeleniumOptions we only want to run the patch when
      # we are on browsers without the relevant JSON fixes in upstream
      def patch!
        return unless valid?

        super
      end

      private

      def valid?
        %i[firefox safari].include?(@browser)
      end

      def description
        <<~DESCRIPTION
          This patch fixes an issue with Selenium4 not camelising the browser_name property
          The issue is the driver, which is now fully W3C conformant expects `browserName`

          See: https://github.com/SeleniumHQ/selenium/pull/8834 for more details/discussion including this fix
        DESCRIPTION
      end

      def perform
        case @browser
        when :firefox then ::Selenium::WebDriver::Firefox::Options.include CapabilitiesAsJsonFix
        when :safari then ::Selenium::WebDriver::Safari::Options.include CapabilitiesAsJsonFix
        end
      end

      def deprecate_from
        '4.0.0'
      end

      def prevent_usage_from
        '4.0.3'
      end

      def gem_version
        ::Selenium::WebDriver::VERSION
      end
    end

    #
    # @api private
    #
    module CapabilitiesAsJsonFix
      private

      def generate_as_json(value, camelize_keys: true)
        if value.is_a?(Hash)
          value.each_with_object({}) do |(key, val), hash|
            key = convert_json_key(key, camelize: camelize_keys)
            hash[key] = generate_as_json(val, camelize_keys: key != 'prefs')
          end
        else
          super
        end
      end
    end
  end
end
