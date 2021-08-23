# frozen_string_literal: true

module CaTesting
  module Drivers
    module V4
      module Browserstack
        class Chrome
          class << self
            # @return [Hash]
            #
            # Returns the Specific Nested Google capabilities for a W3C-compliant Chrome Driver
            def capabilities
              {
                "goog:loggingPrefs" => {
                  browser: "ALL",
                  driver: "ALL"
                }
              }
            end
          end
        end
      end
    end
  end
end
