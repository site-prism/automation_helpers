# frozen_string_literal: true

require "automation_extensions/drivers/v4/local"

# {AutomationExtensions} namespace
module AutomationExtensions
  module Drivers
    # The local driver configuration for running Capybara-wrapped Selenium
    # By default we want to use the V4 local (But others may be supported)
    Local = V4::Local
  end
end
