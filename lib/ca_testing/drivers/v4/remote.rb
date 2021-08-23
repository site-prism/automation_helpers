# frozen_string_literal: true

require "selenium/webdriver/remote"

require "ca_testing/drivers/v4/options"

module CaTesting
  module Drivers
    module V4
      class Remote
        attr_reader :browser
        private :browser

        def initialize(browser)
          @browser = browser
        end

        # @return [Nil]
        #
        # Register a new driver with the default selenium name for use in a (localised), remote grid setup
        def register
          Capybara.register_driver :selenium do |app|
            Capybara::Selenium::Driver.new(
              app,
              browser: :remote,
              capabilities: [browser_capabilities, options],
              url: hub_url
            )
          end
        end

        private

        def browser_capabilities
          Capabilities.for(browser)
        end

        def options
          Options.for(browser)
        end

        def hub_url
          ENV["HUB_URL"]
        end
      end
    end
  end
end
