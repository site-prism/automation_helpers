# frozen_string_literal: true
module AutomationExtensions
  module Drivers
    # {AutomationExtensions::Drivers::V4} namespace
    module V4
      # The local driver configuration for running Capybara-wrapped Selenium
      class Local
        def initialize(browser)
          @browser = browser
        end

        def create
          Capybara.register_driver :selenium do |app|
            Capybara::Selenium::Driver.new(
              app,
              browser: @browser,
              service: service,
              capabilities: [desired_capabilities, options]
            )
          end
        end

        private

        # This is required to make local drivers work exclusively with Safari TP
        # This is required in V13 of Safari as the driver there is notoriously flaky
        # In V12 it doesn't hinder it
        # We don't support Safari V11!
        def service
          return unless safari?

          Selenium::WebDriver::Safari.technology_preview!
          Selenium::WebDriver::Service.safari({ args: ["--diagnose"] })
        end

        def desired_capabilities
          Selenium::WebDriver::Remote::Capabilities.new.tap do |capabilities|
            if safari?
              capabilities["browserName"] = "Safari Technology Preview"
              AutomationLogger.debug("Altering Browser Name request to alleviate Capybara failure with STP.")
            end
          end
        end

        def safari?
          @browser == :safari
        end
      end
    end
  end
end


#
