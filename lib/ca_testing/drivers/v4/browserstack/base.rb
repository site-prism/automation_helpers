# frozen_string_literal: true

module CaTesting
  module Drivers
    module V4
      module Browserstack
        class Base
          #
          # api private (Not intended to be instantiated directly!)
          #
          attr_reader :browser, :browserstack_options, :defined_capabilities
          private :browser, :browserstack_options, :defined_capabilities

          def initialize(browser, browserstack_options, defined_capabilities = nil)
            @browser = browser
            @browserstack_options = browserstack_options
            @defined_capabilities = defined_capabilities
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
              Faraday::Utils.deep_merge(
                # Browserstack Capabilities and General Capabilities are at different levels, so we merge first
                browserstack_capabilities.merge(general_browser_capabilities),
                # Then we deep merge with anything specific to each browser, as these can be nested and require merging
                specific_browser_capabilities
              )
            )
          end

          def browserstack_capabilities
            Faraday::Utils.deep_merge(configured_browserstack_capabilities, static_browserstack_capabilities)
          end

          def configured_browserstack_capabilities
            {
              "bstack:options" => {
                "buildName" => browserstack_options[:build_name],
                "projectName" => browserstack_options[:project_name],
                "sessionName" => browserstack_options[:session_name],
                "debug" => browserstack_options[:browserstack_debug_mode],
                "os" => os,
                "osVersion" => os_version
              }
            }
          end

          def static_browserstack_capabilities
            {
              "bstack:options" => {
                "local" => "false",
                "seleniumVersion" => "4.0.0-alpha-6",
                "consoleLogs" => "verbose",
                "networkLogs" => "true",
                "resolution" => "1920x1080"
              }
            }
          end

          def general_browser_capabilities
            return {} if device?

            { "browserVersion" => browser_version }
          end

          def specific_browser_capabilities
            defined_capabilities || {}
          end

          def options
            CaTesting::Drivers::V4::Options.for(browser)
          end

          def browserstack_hub_url
            "https://#{browserstack_options[:username]}:#{browserstack_options[:api_key]}@hub-cloud.browserstack.com/wd/hub"
          end

          def os
            browserstack_options[:config].split("_")[0]
          end

          def os_version
            browserstack_options[:config].split("_")[1]
          end

          def browser_version
            browserstack_options[:config].split("_")[2]
          end

          def device?
            %i[android ios].include?(browser)
          end
        end
      end
    end
  end
end
