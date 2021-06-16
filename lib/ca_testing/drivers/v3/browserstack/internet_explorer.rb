# frozen_string_literal: true

module CaTesting
  module Drivers
    module V3
      module Browserstack
        class InternetExplorer
          # @return [Hash]
          #
          # Returns the Specific Nested Browserstack capabilities for a W3C-compliant Internet Explorer Driver
          def capabilities
            {
              "browserName" => "internet explorer",
              "bstack:options" => {
                "ie" => {
                  "driver" => "3.141.59",
                  "arch" => "x32"
                }
              }
            }
          end
        end
      end
    end
  end
end
