# frozen_string_literal: true

module Capybara
  module Node
    class Element
      def color
        native.css_value("color")
      end

      def background_color
        native.css_value("background-color")
      end

      def vertical_position
        native.rect[:y].to_i
      end
    end
  end
end
