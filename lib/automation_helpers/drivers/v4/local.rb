# frozen_string_literal: true

require 'selenium/webdriver'

require 'automation_helpers/drivers/v4/options'

module AutomationHelpers
  module Drivers
    module V4
      #
      # The Local Driver that will spin up and run on your machine (Without connecting to any grid)
      #
      class Local
        attr_reader :browser
        private :browser

        # #### Initial setup options
        #
        # - **browser** (required) - When instantiating, the first argument must be the symbol that represents what browser to use
        #
        def initialize(browser)
          @browser = browser
        end

        # @return [Nil]
        #
        # Register a new driver with the default selenium name for use locally
        def register
          Capybara.register_driver :selenium do |app|
            Capybara::Selenium::Driver.new(
              app,
              browser: browser,
              service: service,
              options: options
            )
          end
        end

        private

        # This is required to make local drivers work with Safari TP
        # This is required in V13+ of Safari as the driver there is notoriously flaky
        # Safari V11/V12 is unsupported
        def service
          return unless safari?

          ::Selenium::WebDriver::Safari.technology_preview!
          ::Selenium::WebDriver::Service.safari(args: ['--diagnose'])
        end

        def options
          Options.for(browser)
        end

        def safari?
          browser == :safari
        end
      end
    end
  end
end
