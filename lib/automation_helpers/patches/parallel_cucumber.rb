# frozen_string_literal: true

module AutomationHelpers
  module Patches
    class ParallelCucumber < Base
      private

      def description
        <<~DESCRIPTION
          This patch fixes an issue where the parallel tests gem won't place the --retry flag in the correct
          position for command invocation with cucumber
          See: https://github.com/grosser/parallel_tests/pull/827 for more details/discussion including this fix
        DESCRIPTION
      end

      def perform
        ::ParallelTests::Gherkin::Runner.extend RetryFlagFix
      end

      def deprecation_notice_date
        Time.new(2022, 6, 30)
      end

      def prevent_usage_from
        "4.0.0"
      end

      def gem_version
        ::ParallelTests::VERSION
      end
    end

    module RetryFlagFix
      def run_tests(test_files, process_number, num_processes, options)
        # Copied Code - https://github.com/grosser/parallel_tests/blob/master/lib/parallel_tests/gherkin/runner.rb#L9
        combined_scenarios = test_files

        if options[:group_by] == :scenarios
          grouped = test_files.map { |t| t.split(':') }.group_by(&:first)
          combined_scenarios = grouped.map do |file, files_and_lines|
            "#{file}:#{files_and_lines.map(&:last).join(':')}"
          end
        end

        sanitized_test_files = combined_scenarios.map { |val| WINDOWS ? "\"#{val}\"" : Shellwords.escape(val) }

        options[:env] ||= {}
        options[:env] = options[:env].merge({ 'AUTOTEST' => '1' }) if $stdout.tty?

        # New code
        opts = cucumber_opts(options[:test_options])
        cmd = [
          executable,
          (runtime_logging if File.directory?(File.dirname(runtime_log))),
          opts[0],
          *sanitized_test_files,
          opts[1]
        ].compact.reject(&:empty?).join(' ')
        execute_command(cmd, process_number, num_processes, options)
      end

      def cucumber_opts(given)
        # All new code
        initial =
          if given =~ (/--profile/) || given =~ (/(^|\s)-p /)
            given
          else
            [given, profile_from_config].compact.join(" ")
          end

        opts_as_individuals = initial.scan(/\S+\s\S+/)
        desired_output = ['', '']

        opts_as_individuals.each do |opt|
          if opt.match?(/--retry \d+/)
            desired_output[1] = opt
          else
            desired_output[0] = "#{desired_output[0]} #{opt}".strip
          end
        end

        desired_output
      end
    end
  end
end
