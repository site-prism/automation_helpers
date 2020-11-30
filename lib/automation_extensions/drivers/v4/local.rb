# frozen_string_literal: true
module AutomationExtensions
  module Drivers
    module V4
      class Local
        attr_reader :browser
        private :browser

        def initialize(browser)
          @browser = browser
        end

        def register
          Capybara.register_driver :selenium do |app|
            Capybara::Selenium::Driver.new(
              app,
              browser: browser,
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

          ::Selenium::WebDriver::Safari.technology_preview!
          ::Selenium::WebDriver::Service.safari({ args: ["--diagnose"] })
        end

        # This is required because Capybara and Safari aren't quite sure what the difference
        # is between the two browsers. So to compensate an illegal browserName value is
        # set that allows easy distinction between the two browsers
        #
        # NB: Whilst using Safari TP this is required. When not using Safari TP, this can
        # be removed
        def desired_capabilities
          ::Selenium::WebDriver::Remote::Capabilities.new.tap do |capabilities|
            if safari?
              capabilities["browserName"] = "Safari Technology Preview"
              # TOFIX: Implement logger
              # AutomationLogger.debug("Altering Browser Name request to alleviate Capybara failure with STP.")
              warn "Altering Browser Name request to alleviate Capybara failure with STP."
            end
          end
        end

        def options
          Options.new(browser).options
        end

        def safari?
          browser == :safari
        end
      end
    end
  end
end
