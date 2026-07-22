# frozen_string_literal: true

module SpecSupport
  module Browser
    def capybara_session(type = :selenium_chrome_headless)
      Capybara::Session.new(type)
    end

    def visible_capybara_session(type = :selenium_chrome)
      Capybara::Session.new(type)
    end

    def legacy_capybara?
      Gem::Version.new(Capybara::VERSION) < Gem::Version.new('3.40')
    end

    def capybara_in_visible_viewport?(element)
      session.evaluate_script(viewport_visibility_js, element.native)
    end

    def selenium_in_visible_viewport?(element)
      driver.execute_script(viewport_visibility_js, element)
    end

    def viewport_visibility_js
      <<~JS
        (function(el) {
          const rect = el.getBoundingClientRect();

          return (
            rect.top < window.innerHeight &&
            rect.bottom > 0 &&
            rect.left < window.innerWidth &&
            rect.right > 0
          );
        })(arguments[0]);
      JS
    end
  end
end
