# frozen_string_literal: true

require "selenium-webdriver"
require "capybara"
require "capybara/dsl"
require "webdrivers"
require "cucumber"

require "ca_testing"

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

Capybara.configure do |config|
  config.app_host = "file://#{File.dirname(__FILE__)}/support/fixtures"
end

CaTesting.configure do |config|
  config.log_level = :UNKNOWN
end

def capture_stdout
  original_stdout = $stdout
  $stdout = StringIO.new
  yield
  $stdout.string
ensure
  $stdout = original_stdout
end

def wipe_logger!
  return unless CaTesting.instance_variable_get(:@logger)

  CaTesting.remove_instance_variable(:@logger)
end

def lines(string)
  string.split("\n").length
end
