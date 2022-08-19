# frozen_string_literal: true

require 'automation_helpers/drivers/v4/capabilities'
require 'automation_helpers/drivers/v4/options'

module AutomationHelpers
  module Drivers
    module V4
      #
      # {AutomationHelpers::Drivers::V4::Remote}
      #
      # The Remote Driver that will connect to a dockerised self-hosted grid
      # Expects the grid to be live and accepting node requests
      #
      class Remote
        attr_reader :browser
        private :browser

        # #### Initial setup options
        #
        # - **browser** (required) - When instantiating, the first argument must be the symbol that represents what browser to use
        # - **ENV["HUB_URL"]** (required) - The environment variable HUB_URL must be set to the actively running dockerised grid
        #   (By default this should be +http://hub:4444/wd/hub+)
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
          raise ArgumentError, 'You must use a supported browser' unless supported_browser?

          Capabilities.for(browser)
        end

        def options
          Options.for(browser)
        end

        def hub_url
          ENV.fetch('HUB_URL')
        end

        def supported_browser?
          %i[chrome firefox].include?(browser)
        end
      end
    end
  end
end
