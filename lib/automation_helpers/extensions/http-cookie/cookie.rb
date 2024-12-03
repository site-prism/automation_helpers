# frozen_string_literal: true

module HTTP
  #
  # Additional useful methods to extend the HTTP::Cookie class with
  #
  class Cookie
    # @return [Hash]
    #
    # A hashified representation of the cookie that will enable you to push it into Selenium Manager
    def to_h
      {
        name: name,
        value: value,
        path: path,
        secure: secure,
        expires: expires
      }
    end
  end
end
