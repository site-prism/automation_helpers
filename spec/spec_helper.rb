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

RSpec.configure do |config|
  config.include SpecSupport::Console
end

def wipe_logger!
  return unless AutomationHelpers.instance_variable_get(:@logger)

  AutomationHelpers.remove_instance_variable(:@logger)
end

def capybara_session(type = :selenium_chrome_headless)
  Capybara::Session.new(type)
end

def old_selenium?
  Gem::Version.new(Selenium::WebDriver::VERSION) < Gem::Version.new('4.7')
end
