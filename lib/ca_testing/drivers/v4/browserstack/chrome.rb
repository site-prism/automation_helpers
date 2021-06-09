# frozen_string_literal: true

module CaTesting
  module Drivers
    module V4
      module Browserstack
        class Chrome
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
