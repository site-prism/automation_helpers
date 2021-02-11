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
        # Store previously set values
        previous_internal = Encoding.default_internal
        previous_external = Encoding.default_external

        # Set them to ASCII_8BIT which seems to like writing special characters
        Encoding.default_internal = Encoding.default_external = Encoding::ASCII_8BIT

        # Set the outputter property to write to this desired encoding
        outputter = @logger.instance_variable_get(:@logdev).dev
        outputter.set_encoding(Encoding.default_internal, Encoding.default_external)

        # Restore previous values
        Encoding.default_internal = previous_internal
        Encoding.default_external = previous_external
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
