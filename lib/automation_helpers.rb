# frozen_string_literal: true

require 'automation_helpers/drivers'
require 'automation_helpers/extensions'
require 'automation_helpers/patches'
require 'automation_helpers/version'

# {AutomationHelpers} namespace
module AutomationHelpers
  class << self
    attr_accessor :chrome_log_path

    def configure
      yield self
    end
  end
end
