# frozen_string_literal: true

require 'selenium/webdriver'

module AutomationHelpers
  module Drivers
    module V4
      #
      # The Options object for the relevant browser whose driver you are configuring
      #
      # #### Initial setup options
      #
      # - **ENV["HEADLESS"]** (optional) - Whether you want your browser (only applicable ones) to run headless or not
      class Options
        class << self
          # @return [Selenium::Webdriver::Options]
          #
          # Returns the Options payload relevant to the browser specified to be passed to the driver instantiation
          def for(browser)
            case browser
            when :chrome;             then chrome_options
            when :firefox;            then firefox_options
            when :edge;               then edge_options
            when :safari;             then safari_options
            when :internet_explorer;  then internet_explorer_options
            else {}
            end
          end

          private

          def chrome_options
            ::Selenium::WebDriver::Chrome::Options.new.tap { |opts| opts.add_argument('--headless=new') if headless? }
          end

          def firefox_options
            ::Selenium::WebDriver::Firefox::Options.new(log_level: 'trace').tap { |opts| opts.add_argument('-headless') if headless? }
          end

          def edge_options
            ::Selenium::WebDriver::Edge::Options.new.tap { |opts| opts.add_argument('--headless=new') if headless? }
          end

          def safari_options
            ::Selenium::WebDriver::Safari::Options.new(automatic_inspection: true)
          end

          # Constantly fire mouseOver events on click actions (Should help mitigate flaky clicks)
          def internet_explorer_options
            ::Selenium::WebDriver::IE::Options.new(persistent_hover: true)
          end

          def headless?
            ENV.fetch('HEADLESS', 'false') == 'true'
          end
        end
      end
    end
  end
end
