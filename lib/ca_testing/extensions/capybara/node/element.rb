# frozen_string_literal: true

module Capybara
  module Node
    class Element
      def horizontal_position
        native.rect[:x].to_i
      end

      def vertical_position
        native.rect[:y].to_i
      end
    end
  end
end
