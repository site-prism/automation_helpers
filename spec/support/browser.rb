# frozen_string_literal: true

module SpecSupport
  module Browser
    def capybara_session(type = :selenium_chrome_headless)
      Capybara::Session.new(type)
    end

    def old_selenium?
      Gem::Version.new(Selenium::WebDriver::VERSION) < Gem::Version.new('4.7')
    end

    def incompatible_capybara_and_selenium_versions?
      Gem::Version.new(Capybara::VERSION) > Gem::Version.new('3.35') &&
        Gem::Version.new(Capybara::VERSION) < Gem::Version.new('3.40') &&
        Gem::Version.new(Selenium::WebDriver::VERSION) > Gem::Version.new('4.10') &&
        Gem::Version.new(Selenium::WebDriver::VERSION) < Gem::Version.new('4.20')
    end
  end
end
