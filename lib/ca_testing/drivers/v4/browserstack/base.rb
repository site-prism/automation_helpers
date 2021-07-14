# frozen_string_literal: true

module CaTesting
  module Drivers
    module V4
      module Browserstack
        class Base
          include Helpers::EnvVariables

          attr_reader :browser, :browserstack_options
          private :browser, :browserstack_options

          def initialize(browser, browserstack_options)
            @browser = browser
            @browserstack_options = browserstack_options
          end

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
              Faraday::Utils.deep_merge(standard_capabilities, specific_browser_capabilities)
            )
          end

          def standard_capabilities
            standard_browserstack_capabilities.merge(general_browser_capabilities)
          end

          def specific_browser_capabilities
            {}
          end

          def general_browser_capabilities
            return {} if device?

            { "browserVersion" => browser_version }
          end

          def standard_browserstack_capabilities
            {
              "bstack:options" => {
                "buildName" => browserstack_options[:build_name],
                "projectName" => "Public-Website tests",
                "sessionName" => browserstack_options[:session_name],
                "os" => os,
                "osVersion" => os_version,
                "local" => "false",
                "seleniumVersion" => "4.0.0-alpha-6",
                "debug" => browserstack_options[:browserstack_debug_mode],
                "consoleLogs" => "verbose",
                "networkLogs" => "true",
                "resolution" => "1920x1080"
              }
            }
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
