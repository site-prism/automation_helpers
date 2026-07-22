# frozen_string_literal: true

module Selenium
  module WebDriver
    #
    # Additional useful methods to extend the Selenium::WebDriver::Element class with
    #
    class Element
      # @return [Selenium::WebDriver::Element]
      #
      # Scrolls the element directly into view. Useful to mitigate vs stale element errors
      def scroll_into_view
        @bridge.execute_script(
          "arguments[0].scrollIntoView({block: 'center', inline: 'nearest'});",
          self
        )
        self
      end
    end
  end
end
