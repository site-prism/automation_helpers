# frozen_string_literal: true

module CaTesting
  module Patches
    class Sample < Base
      private

      def description
        <<~DESCRIPTION
          This is a sample patch. The file/class structure is here.
          We will remove this sample file once we have a couple of sample patches merged
        DESCRIPTION
      end

      def perform
        :change_some_behaviour
      end

      def deprecation_notice_date
        Time.new(2021, 2, 2)
      end

      def prevent_usage_date
        Time.new(2021, 5, 2)
      end
    end
  end
end
