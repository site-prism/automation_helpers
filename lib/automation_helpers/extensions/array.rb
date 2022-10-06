# frozen_string_literal: true

# Additional useful methods to extend the Array class with
class Array
  # @return [Array]
  #
  # Generates an array of the english alphabet
  # Accepts an input to determine what case of alphabet you want
  def self.alphabet(type = :upper)
    case type
    when :upper; then ('A'..'Z').to_a
    when :lower; then ('a'..'z').to_a
    when :both;  then ('a'..'z').to_a + ('A'..'Z').to_a
    else raise ArgumentError, 'Invalid alphabet type. Must be :upper (default), :lower or :both'
    end
  end

  # @return [Array]
  #
  # Return the non-unique items of an array
  def non_uniq
    tally.select { |_key, count| count > 1 }.map(&:first)
  end

  # @return [Boolean]
  #
  # Test whether an array is wholly unique
  def uniq?
    uniq == self
  end
end
