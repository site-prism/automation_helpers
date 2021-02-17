# frozen_string_literal: true

module CaTesting
  module Patches
    class SeleniumOptions < Base
      def initialize(browser)
        @browser = browser
        super()
      end

      def patch!
        return unless valid?

        super
      end

      def valid?
        %i[firefox safari].include?(@browser)
      end

      private

      def description
        <<~DESCRIPTION
          TODO
        DESCRIPTION
      end

      def perform
        case @browser
        when :firefox then Selenium::WebDriver::Firefox::Options.include CapabilitiesAsJsonFix
        when :safari then Selenium::WebDriver::Safari::Options.include CapabilitiesAsJsonFix
        end
      end

      def deprecation_notice_date
        Time.new(2021, 12, 25)
      end

      def prevent_usage_date
        Time.new(2022, 6, 30)
      end
    end

    module CapabilitiesAsJsonFix
      private

      def generate_as_json(value, camelize_keys: true)
        if value.is_a?(Hash)
          value.each_with_object({}) do |(key, val), hash|
            key = convert_json_key(key, camelize: camelize_keys)
            hash[key] = generate_as_json(val, camelize_keys: key != "prefs")
          end
        else
          super
        end
      end
    end
  end
end
