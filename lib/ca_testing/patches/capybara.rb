# frozen_string_literal: true

module CaTesting
  module Patches
    class Capybara < Base
      private

      def description
        <<~DESCRIPTION
          This patch is necessary when using the Safari browser. There is a bug in the text method and capybara
          maintainers aren't willing to fix because according to them 'safari should fix their driver'.
          As such we need to use Module.prepend, to ensure the correct default value is being passed.
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
