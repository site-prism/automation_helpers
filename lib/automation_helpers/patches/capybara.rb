# frozen_string_literal: true

module AutomationHelpers
  module Patches
    #
    # Fix the issue where the `#text` method doesn't normalize whitespace (Only the matchers do)
    #
    class Capybara < Base
      private

      def description
        <<~DESCRIPTION
          There is a bug in the #text method as Safari's w3c conformant endpoint isn't w3c conformant.

          See https://github.com/teamcapybara/capybara/issues/2213 for more details.
        DESCRIPTION
      end

      def perform
        ::Capybara::Node::Element.prepend SafariTextPatch
      end
    end

    #
    # @api private
    #
    module SafariTextPatch
      def text(type = nil, normalize_ws: ::Capybara.default_normalize_ws)
        super
      end
    end
  end
end
