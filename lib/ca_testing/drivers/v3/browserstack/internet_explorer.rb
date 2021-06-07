# frozen_string_literal: true

module CaTesting
  module Drivers
    module V3
      module Browserstack
        class InternetExplorer
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
