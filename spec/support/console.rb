# frozen_string_literal: true

module SpecSupport
  module Console
    def capture_stdout
      original_stdout = $stdout
      $stdout = StringIO.new
      yield
      $stdout.string
    ensure
      $stdout = original_stdout
    end

    def lines(string)
      string.split("\n").length
    end
  end
end
