# frozen_string_literal: true

class String
  def pascalize
    split("_").map(&:capitalize).join
  end

  def snake_case
    gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .tr("-", "_")
      .tr(" ", "_")
      .tr("'", "")
      .squeeze(" ")
      .downcase
  end
end
