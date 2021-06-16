# frozen_string_literal: true

module CaTesting
  module Drivers
    module V4
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
            when :firefox;            then ::Selenium::WebDriver::Firefox::Options.new(log_level: "trace")
            when :edge;               then ::Selenium::WebDriver::Edge::Options.new
            when :safari;             then ::Selenium::WebDriver::Safari::Options.new(automatic_inspection: true)
            when :internet_explorer;  then internet_explorer_options
            else {}
            end
          end

          # Constantly fire mouseOver events on click actions (Should help mitigate flaky clicks)
          def internet_explorer_options
            ::Selenium::WebDriver::IE::Options.new(persistent_hover: true).tap do |opts|
              # This is needed to mitigate a Selenium4/Browserstack issue whereby in Se4
              # we combine Browser options and Capabilities and merge them. But for some
              # reason Browserstack insist on giving `internet_explorer` a non-conformant
              # name `IE`. This then causes huge issues in trying to find a browser that
              # would match using firstMatch in 2 different ways.
              #
              # A Support ticket has been raised with Browserstack to see if they can fix
              # anything at their end, as this is a bug with their matching protocols
              # LH - Aug 2020
              CaTesting.logger.info("Removing `browser_name` key from options payload.")
              opts.options.delete(:browser_name)
            end
          end

          def headless?
            ENV["HEADLESS"] == "true"
          end
        end
      end
    end
  end
end
