# frozen_string_literal: true

class Array
  # @return [Boolean]
  #
  # Test whether an array is wholly unique
  def uniq?
    uniq == self
  end

  # @return [Array]
  #
  # Return the non-unique items of an array
  def non_uniq
    tally.select { |_key, count| count > 1 }.map(&:first)
  end
end
