# frozen_string_literal: true

module HTTP
  #
  # Additional useful methods to extend the HTTP::CookieJar class with
  #
  class CookieJar
    # @return [HTTP::Cookie || Nil]
    #
    # The cookie that has the supplied name
    def cookie_named(name)
      cookies.detect { |cookie| cookie.name == name }
    end

    # @return [Boolean]
    #
    # Whether the cookie jar contains the cookie with the supplied name
    def include?(cookie_name)
      cookies.any? { |cookie| cookie.name == cookie_name }
    end
  end
end
