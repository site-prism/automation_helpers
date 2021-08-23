# frozen_string_literal: true

module CaTesting
  module Drivers
    module V4
      module Browserstack
        class Ios
          class << self
            # @return [Hash]
            #
            # Returns the Specific Nested Browserstack capabilities for a W3C-compliant Ios Driver
            def capabilities(device_options)
              {
                "bstack:options" => {
                  "deviceName" => device_options[:device_name],
                  "realMobile" => "true",
                  "appiumVersion" => appium_version(device_options[:ios_version])
                }
              }
            end

            private

            def appium_version(ios_version)
              case ios_version.to_f
              when 14..15; then "1.20.3"
              when 13..14; then "1.20.2"
              when 12..13; then "1.19.1"
              when 11..12; then "1.16.0"
              else raise ArgumentError, "Your iOS Version is too low. Please don't use lower than iOS 11."
              end
            end
          end
        end
      end
    end
  end
end
