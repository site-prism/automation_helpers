# frozen_string_literal: true

require "ca_testing/drivers/v4/options"

module CaTesting
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
              capabilities: capabilities
            )
          end
        end

        # The order of these capabilities is important because in the internal configuration
        # for the driver; these 2 objects are merged (And both will contain a browserName)
        # as such we need to ensure the browserName we manually set in `desired_capabilities`
        # is retained as this is the one required by safari
        def capabilities
          if safari?
            [options, desired_capabilities]
          else
            [desired_capabilities, options]
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
              CaTesting.logger.warn("Altering Browser Name request to alleviate Capybara failure with STP.")
            end
          end
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
