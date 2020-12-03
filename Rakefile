# frozen_string_literal: true

require "rspec/core/rake_task"
require "rubocop/rake_task"

RuboCop::RakeTask.new(:rubocop)
RSpec::Core::RakeTask.new(:rspec)

task default: %i[rspec rubocop]
