# frozen_string_literal: true

require "selenium/webdriver"

module CaTesting
  module Drivers
    module V4
      class Capabilities
        class << self
          # @return [Selenium::WebDriver::Remote::Capabilities]
          #
          # Returns the Capabilities hash relevant to the browser specified to be passed to the driver instantiation
          def for(browser, device_options = {})
            ::Selenium::WebDriver::Remote::Capabilities.new(capabilities_hash(browser, device_options))
          end

          private

          def capabilities_hash(browser, device_options)
            case browser
            when :android;           then android_capabilities(device_options)
            when :chrome;            then chrome_capabilities
            when :firefox;           then firefox_capabilities
            when :internet_explorer; then internet_explorer_capabilities
            when :ios;               then ios_capabilities(device_options)
            else {}
            end
          end

          def android_capabilities(device_options)
            {
              "bstack:options" => {
                "deviceName" => device_options[:device_name],
                "realMobile" => "true",
                "appiumVersion" => android_appium_version(device_options[:os_version])
              }
            }
          end

          def chrome_capabilities
            {
              "browserName" => "chrome",
              "goog:loggingPrefs" => {
                "browser" => "ALL",
                "driver" => "ALL"
              }
            }
          end

          def firefox_capabilities
            {
              "browserName" => "firefox"
            }
          end

          def internet_explorer_capabilities
            {
              "browserName" => "internet explorer",
              "bstack:options" => {
                "ie" => {
                  # This is a minor hack until the IEDriver catches up and releases a V4 compliant copy
                  # It is confirmed to be compliant with V4 selenium jars e.t.c.
                  "driver" => "3.141.59",
                  "arch" => "x32"
                }
              }
            }
          end

          def ios_capabilities(device_options)
            {
              "bstack:options" => {
                "deviceName" => device_options[:device_name],
                "realMobile" => "true",
                "appiumVersion" => ios_appium_version(device_options[:os_version])
              }
            }
          end

          def android_appium_version(android_version)
            case android_version.to_f
            when 10..; then "1.21.0"
            when 9..;  then "1.20.2"
            else raise ArgumentError, "Your Android Version is too low. Please don't use lower than Android Pie (9)."
            end
          end

          def ios_appium_version(ios_version)
            case ios_version.to_f
            when 13..; then "1.21.0"
            when 12..; then "1.20.2"
            when 11..; then "1.16.0"
            else raise ArgumentError, "Your iOS Version is too low. Please don't use lower than iOS 11."
            end
          end
        end
      end
    end
  end
end
