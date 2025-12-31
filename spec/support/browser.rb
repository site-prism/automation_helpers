# frozen_string_literal: true

module SpecSupport
  module Browser
    def capybara_session(type = :selenium_chrome_headless)
      Capybara::Session.new(type)
    end

    def legacy_capybara?
      Gem::Version.new(Capybara::VERSION) < Gem::Version.new('3.40')
    end
  end
end
