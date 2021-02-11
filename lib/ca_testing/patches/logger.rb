# frozen_string_literal: true

module CaTesting
  module Patches
    class Logger < Base
      private

      def description
        <<~DESCRIPTION
          This enables any Logger to convert it's encoding to one which supports special characters.
          Examples of this are things like © which use the ASCII encoding protocol (Instead of UTF-8).
        DESCRIPTION
      end

      def perform
        :change_some_behaviour
      end

      def deprecation_notice_date
        Time.new(2022, 1, 1)
      end

      def prevent_usage_date
        Time.new(3000, 1, 1)
      end
    end
  end
end
