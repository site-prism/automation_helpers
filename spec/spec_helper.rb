# frozen_string_literal: true

require 'selenium/webdriver'
require 'capybara'
require 'capybara/dsl'
require 'webdrivers'
require 'cucumber'
require 'parallel_tests/gherkin/runner'

require 'automation_helpers'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

Capybara.configure do |config|
  config.app_host = "file://#{File.dirname(__FILE__)}/support/fixtures"
  config.default_max_wait_time = 0
end

AutomationHelpers.configure do |config|
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
  return unless AutomationHelpers.instance_variable_get(:@logger)

  AutomationHelpers.remove_instance_variable(:@logger)
end

def lines(string)
  string.split("\n").length
end

def run_selenium_options_patch?
  Selenium::WebDriver::VERSION <= '4.0.0.beta5'
end

def flaky_spec?
  old_ruby? && old_capybara?
end

def old_ruby?
  RUBY_VERSION.to_f < 3
end

def old_capybara?
  Gem::Version.new(Capybara::VERSION) < Gem::Version.new('3.30')
end

def capybara_session(type = :selenium_chrome_headless)
  Capybara::Session.new(type)
end
