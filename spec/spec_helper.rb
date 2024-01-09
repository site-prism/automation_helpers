# frozen_string_literal: true

require 'selenium/webdriver'
require 'capybara'
require 'capybara/dsl'
require 'cucumber'

require 'automation_helpers'

Dir['./spec/support/**/*.rb'].each { |f| require f }

Capybara.configure do |config|
  config.app_host = "file://#{File.dirname(__FILE__)}/support/fixtures"
  config.default_max_wait_time = 0
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

def capybara_session(type = :selenium_chrome_headless)
  Capybara::Session.new(type)
end

def incompatible_capybara?
  Gem::Version.new(Capybara::VERSION) < Gem::Version.new('3.36')
end

def old_selenium?
  Gem::Version.new(Selenium::WebDriver::VERSION) < Gem::Version.new('4.7')
end
