# frozen_string_literal: true

require 'automation_helpers/drivers'
require 'automation_helpers/extensions'
require 'automation_helpers/logger'
require 'automation_helpers/patches'
require 'automation_helpers/version'

# {AutomationHelpers} namespace
module AutomationHelpers
  class << self
    attr_accessor :chrome_log_path

    def configure
      yield self
    end

    # The Automation Helpers logger object - This is called automatically in several
    # locations and will log messages according to the normal Ruby protocol
    #
    # This logger object can also be used to manually log messages
    #
    # To Manually log a message
    #   AutomationHelpers.logger.info('Information')
    #   AutomationHelpers.logger.debug('Input debug message')
    #
    # By default the logger will output all messages to $stdout, but can be
    # altered to log to a file or another IO location by calling `.log_path=`
    def logger
      @logger ||= Logger.create
    end

    # This writer method allows you to configure where you want the output of
    # the automation_helpers logs to go (Default is $stdout)
    #
    # example: AutomationHelpers.log_path = 'automation_helpers.log' would save all
    # log messages to `./automation_helpers.log`
    def log_path=(logdev)
      logger.reopen(logdev)
    end
  end
end
