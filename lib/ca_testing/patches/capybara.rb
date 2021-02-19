# frozen_string_literal: true

module CaTesting
  module Patches
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

      def deprecate?
        false
      end
    end

    module SafariTextPatch
      def text(type = nil, normalize_ws: ::Capybara.default_normalize_ws)
        super(type, normalize_ws: normalize_ws)
      end
    end
  end
end
