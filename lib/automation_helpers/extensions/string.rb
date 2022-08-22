# frozen_string_literal: true

# Additional useful methods to extend the String class with
class String
  # @return [String]
  #
  # Convert's a regular string name into it's pascalized format
  # This can then be used to generate a ClassName
  def pascalize
    split('_').map(&:capitalize).join
  end

  # @return [String]
  #
  # Convert's a regular string into a snake cased format
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

  # @return [String]
  #
  # Sanitize and convert every individual whitespace character to
  # a regular space character (Does not sanitize newlines)
  def sanitize_whitespace
    gsub(/[ \t\r\f\u00A0]/, ' ')
  end

  # @return [Boolean]
  #
  # Cast any string to true or false
  def to_bool
    %w[yes on true].include?(downcase)

    %w[yes on true].any? { |positive| positive.casecmp?(self) }
  end
end
