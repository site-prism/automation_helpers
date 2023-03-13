# frozen_string_literal: true

# Additional useful methods to extend the String class with
class String
  # @return [String]
  #
  # Generates a single random letter from an array of the english alphabet
  # Accepts an input to determine what case of alphabet you want
  def self.alphabet_char(type = :upper)
    case type
    when :upper; then ('A'..'Z').to_a.sample
    when :lower; then ('a'..'z').to_a.sample
    when :both;  then (('a'..'z').to_a + ('A'..'Z').to_a).sample
    else raise ArgumentError, 'Invalid alphabet type. Must be :upper (default), :lower or :both'
    end
  end

  # @return [String]
  #
  # Converts a regular string name into it's pascalized format
  # This can then be used to generate a ClassName
  def pascalize
    split('_').map(&:capitalize).join
  end

  # @return [String]
  #
  # Sanitize and convert every individual whitespace character to
  # a regular space character (Does not sanitize newlines)
  def sanitize_whitespace
    gsub(/[ \t\r\f\u00A0]/, ' ')
  end

  # @return [String]
  #
  # Converts a regular string into a snake cased format
  # Will sanitize out some characters (Designed for titles)
  def snake_case
    gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .squeeze(' ')
      .tr('-', '_')
      .tr(' ', '_')
      .tr("'", '')
      .downcase
  end

  # @return [Boolean]
  #
  # Cast any string to true or false
  def to_bool
    %w[yes on true].include?(downcase)
  end
end
