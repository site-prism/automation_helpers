# frozen_string_literal: true

module Capybara
  module Node
    #
    # Additional useful methods to extend the Capybara::Node::Element class with
    #
    class Element
      # @return [Integer]
      #
      # The Left-Most pixel's horizontal position in the DOM (From element.rect)
      def horizontal_position
        native.rect.x.to_i
      end

      # @return [Integer]
      #
      # The Left-Most pixel's vertical position in the DOM (From element.rect)
      def vertical_position
        native.rect.y.to_i
      end

      # @return [Boolean]
      #
      # Whether the element is in a stale state or not
      def stale?
        inspect == 'Obsolete #<Capybara::Node::Element>'
      end
    end
  end
end
