# frozen_string_literal: true

module Cucumber
  module Core
    module Test
      class Case
        # @return [String]
        #
        # The file name of the feature being ran (Without the .feature extension)
        def feature_file_name
          feature_file_path.split("/").last&.split(".")&.first.to_s
        end

        # @return [String]
        #
        # The fully qualified location of the feature being ran
        def feature_file_path
          location.to_s
        end
      end
    end
  end
end
