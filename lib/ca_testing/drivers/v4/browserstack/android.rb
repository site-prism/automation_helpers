# frozen_string_literal: true

module CaTesting
  module Drivers
    module V4
      module Browserstack
        class Android
          def capabilities
            {
              "bstack:options" => {
                "osVersion" => "10.0",
                "deviceName" => "Samsung Galaxy S20",
                "realMobile" => "true",
                "appiumVersion" => "1.17.0"
              }
            }
          end
        end
      end
    end
  end
end
