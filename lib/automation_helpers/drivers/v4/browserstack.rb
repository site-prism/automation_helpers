# frozen_string_literal: true

require 'faraday'
require 'selenium/webdriver'

require 'automation_helpers/drivers/v4/capabilities'
require 'automation_helpers/drivers/v4/options'

module AutomationHelpers
  module Drivers
    module V4
      #
      # The Browserstack Driver that will connect to a hosted grid
      # This requires a series of pre-set values to be passed in
      #
      class Browserstack
        attr_reader :browser, :browserstack_options, :device_options, :options

        # #### Initial setup options
        #
        # - **browser** (required) - When instantiating, the first argument must be the symbol that represents what browser to use
        # - **browserstack_options** (required) - A Hash of all required options that will be parsed and used to setup the driver
        #   - :build_name (String)               -> The build name to be stored on browserstack servers
        #   - :project_name (String)             -> The project name to be stored on browserstack servers
        #   - :session_name (String)             -> The session name to be stored on browserstack servers
        #   - :browserstack_debug_mode (Boolean) -> Set this to true to run in browserstack debug mode (Note this runs slower!)
        #   - :config (String)                   -> This is an underscore separated key that distils the granular running information
        #     i.e. Windows_7_86 means run on Windows Operating System, OS Version 7, Browser Version 86
        #     i.e. OSX_Mojave_12 means run on Mac Operating System, OS Version Mojave, Browser Version 12
        #     i.e. Windows_10_92 means run on Windows Operating System, OS Version 10, Browser Version 92
        #   - :username (String)                 -> The username for Browserstack
        #   - :api_key (String)                  -> The api key for Browserstack
        # - **device_options** (optional)        - A Hash of all device specific options that can customise your device
        #   - :device_name (String)              -> The name of your device
        #   - :os_version (String)               -> The operating system for your device
        # - **options** (optional) -> You can instantiate an Options payload that can be used when registering your driver
        def initialize(browser, browserstack_options, device_options = {}, options = Options.for(browser))
          @browser = browser
          @browserstack_options = browserstack_options
          @device_options = device_options
          @options = options
        end

        # @return [Nil]
        #
        # Register a new driver with the default selenium name for use in a remote browserstack setup
        def register
          Capybara.register_driver :selenium do |app|
            Capybara::Selenium::Driver.new(
              app,
              browser: :remote,
              capabilities: [desired_capabilities, options],
              url: browserstack_hub_url
            )
          end
        end

        private

        def desired_capabilities
          Selenium::WebDriver::Remote::Capabilities.new(
            ::Faraday::Utils.deep_merge(
              # Browserstack Capabilities and General Capabilities are at different levels, so we merge first
              browserstack_capabilities.merge(browser_version_capability),
              # Then we deep merge with anything specifically passed into the driver registration (as these can be nested)
              browser_specific_capabilities.as_json
            )
          )
        end

        def browserstack_capabilities
          ::Faraday::Utils.deep_merge(configurable_capabilities, static_capabilities)
        end

        def configurable_capabilities
          {
            'bstack:options' => {
              'buildName' => browserstack_options[:build_name],
              'projectName' => browserstack_options[:project_name],
              'sessionName' => browserstack_options[:session_name],
              'debug' => browserstack_options[:browserstack_debug_mode],
              'os' => os,
              'osVersion' => os_version
            }
          }
        end

        def static_capabilities
          {
            'bstack:options' => {
              'local' => 'false',
              'seleniumVersion' => '4.15.0',
              'consoleLogs' => 'verbose',
              'networkLogs' => 'true',
              'resolution' => '1920x1080'
            }
          }
        end

        def browser_specific_capabilities
          Capabilities.for(browser, device_options)
        end

        def browser_version_capability
          return {} if device?

          { 'browserVersion' => browser_version }
        end

        def browserstack_hub_url
          "https://#{browserstack_options[:username]}:#{browserstack_options[:api_key]}@hub-cloud.browserstack.com/wd/hub"
        end

        def os
          browserstack_options[:config].split('_')[0]
        end

        def os_version
          browserstack_options[:config].split('_')[1]
        end

        def browser_version
          browserstack_options[:config].split('_')[2]
        end

        def device?
          %i[android ios].include?(browser)
        end
      end
    end
  end
end
