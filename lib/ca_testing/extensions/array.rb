# frozen_string_literal: true

class String
  # @return [Boolean]
  #
  # Test whether an array is wholly unique
  def uniq?
    self.uniq == self
  end

  # @return [Array]
  #
  # Return the non-unique items of an array
  def non_uniq
    self.tally.select { |_key, count| count > 1 }.map(&:first)
  end
end
