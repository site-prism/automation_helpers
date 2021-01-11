# frozen_string_literal: true

require "ca_testing/drivers/v4/options"
require "selenium/webdriver/remote"

module CaTesting
  module Drivers
    module V4
      class Remote
        attr_reader :browser
        private :browser

        def initialize(browser)
          @browser = browser
        end

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
          case browser
          when :chrome;            then Selenium::WebDriver::Remote::Capabilities.chrome
          when :firefox;           then Selenium::WebDriver::Remote::Capabilities.firefox
          when :internet_explorer; then Selenium::WebDriver::Remote::Capabilities.internet_explorer
          else                     raise ArgumentError, "You must use a supported browser"
          end
        end

        def options
          Options.new(browser).options
        end

        def hub_url
          ENV["HUB_URL"]
        end
      end
    end
  end
end
