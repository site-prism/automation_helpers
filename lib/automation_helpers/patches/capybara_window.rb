# frozen_string_literal: true

module AutomationHelpers
  module Patches
    #
    # Fix the issue where you cannot close the first window in the handle array with `#close_window`
    #
    class CapybaraWindow < Base
      private

      def description
        <<~DESCRIPTION
          The method `#close_window` in Capybara::Selenium::Driver (Base), does not permit closing of the first window in the handle array

          This was introduced over a decade ago and given the propensity for new windows to be opened in the course of testing,
          this is a significant issue for users of Capybara and Selenium.

          NB: WHEN USING THIS PATCH, NETWORK INTERCEPTION IS AFFECTED. DO NOT USE THIS PATCH IF YOU RELY ON NETWORK INTERCEPTION IN YOUR TESTS.

          See https://github.com/teamcapybara/capybara/issues/2834 for more details.
        DESCRIPTION
      end

      def perform
        ::Capybara::Selenium::Driver.prepend WindowPatch
      end
    end

    #
    # @api private
    #
    module WindowPatch
      def close_window(handle)
        within_given_window(handle) do
          browser.close
        end
      end
    end
  end
end
