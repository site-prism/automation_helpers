# frozen_string_literal: true

class Object
  # @return [Boolean]
  #
  # Light(er) form from ActiveSupport so you don't need the whole gem
  # Returns blank on any object that is `nil` or `empty`
  def blank?
    nil? || empty?
  end
end
