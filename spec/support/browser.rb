# frozen_string_literal: true

module SpecSupport
  module Browser
    def capybara_session(type = :selenium_chrome_headless)
      Capybara::Session.new(type)
    end

    def old_selenium?
      Gem::Version.new(Selenium::WebDriver::VERSION) < Gem::Version.new('4.7')
    end
  end
end
