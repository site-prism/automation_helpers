# frozen_string_literal: true

module CaTesting
  module Patches
    class Capybara < Base
      private

      def description
        <<~DESCRIPTION
          TO DO
        DESCRIPTION
      end

      def perform
        perform_safari_text_patch
        perform_firefox_driver_patch
      end

      def deprecate?
        false
      end

      def perform_safari_text_patch
        ::Capybara::Node::Element.prepend SafariTextPatch
      end

      module SafariTextPatch
        def text(type = nil, normalize_ws: ::Capybara.default_normalize_ws)
          super(type, normalize_ws: normalize_ws)
        end
      end
    end
  end
end
