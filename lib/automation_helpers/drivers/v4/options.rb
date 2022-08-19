# frozen_string_literal: true

require 'selenium/webdriver'

module AutomationHelpers
  module Drivers
    module V4
      #
      # {AutomationHelpers::Drivers::V4::Options}
      #
      # The Options object that will be used to instantiate whatever driver you
      # are configuring
      #
      # #### Initial setup options
      #
      # - **ENV["HEADLESS"]** (optional) - Whether you want your browser to run headless or not
      class Options
        class << self
          # @return [Selenium::Webdriver::Options]
          #
          # Returns the Options payload relevant to the browser specified to be passed to the driver instantiation
          def for(browser)
            initial_options(browser).tap { |opts| opts.headless! if headless? }
          end

          private

          def initial_options(browser)
            case browser
            when :chrome;             then ::Selenium::WebDriver::Chrome::Options.new
            when :firefox;            then ::Selenium::WebDriver::Firefox::Options.new(log_level: 'trace')
            when :edge;               then ::Selenium::WebDriver::Edge::Options.new
            when :safari;             then ::Selenium::WebDriver::Safari::Options.new(automatic_inspection: true)
            when :internet_explorer;  then internet_explorer_options
            else {}
            end
          end

          # Constantly fire mouseOver events on click actions (Should help mitigate flaky clicks)
          def internet_explorer_options
            ::Selenium::WebDriver::IE::Options.new(persistent_hover: true).tap do |opts|
              # This can be removed once we migrate past Se4 proper (As the space version name is present there)
              AutomationHelpers.logger.info('Removing `browser_name` key from options payload.')
              opts.options.delete(:browser_name)
            end
          end

          def headless?
            ENV.fetch('HEADLESS', 'false') == 'true'
          end
        end
      end
    end
  end
end
