# frozen_string_literal: true

module Cucumber
  module Core
    module Test
      #
      # Additional useful methods to extend the Cucumber::Core::Test::Case class with
      #
      class Case
        # @return [String]
        #
        # The file name of the feature that is running (Without the .feature extension)
        def feature_file_name
          feature_file_path.split('/').last&.split('.')&.first.to_s
        end

        # @return [String]
        #
        # The fully qualified location (filepath), of the feature file that is running
        def feature_file_path
          location.to_s
        end
      end
    end
  end
end
