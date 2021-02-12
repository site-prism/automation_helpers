# frozen_string_literal: true

module CaTesting
  module Patches
    class Logger < Base
      def initialize(logger)
        @logger = logger
        super()
      end

      private

      def description
        <<~DESCRIPTION
          This enables any Logger to convert it's encoding to one which supports special characters.
          Examples of this are things like © which use the ASCII encoding protocol (Instead of UTF-8).
        DESCRIPTION
      end

      def perform
        # Set the outputter encoding to write to ASCII 8BIT (Which likes writing weird characters)
        outputter = @logger.instance_variable_get(:@logdev).dev
        outputter.set_encoding(Encoding::ASCII_8BIT, Encoding::ASCII_8BIT)
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
