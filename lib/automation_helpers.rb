# frozen_string_literal: true

require 'automation_helpers/drivers'
require 'automation_helpers/extensions'
require 'automation_helpers/logger'
require 'automation_helpers/patches'
require 'automation_helpers/version'

module AutomationHelpers
  class << self
    attr_accessor :chrome_log_path

    def configure
      yield self
    end

    # The Automation Helpers logger object - This is called automatically in several
    # locations and will log messages according to the normal Ruby protocol
    # To alter (or check), the log level; call .log_level= or .log_level
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
    
    def logger=(logger)
      raise ArgumentError, 'You must supply an existing Logger' unless logger.is_a?(::Logger)

      @logger = logger
    end

    # This writer method allows you to configure where you want the output of
    # the automation_helpers logs to go (Default is $stdout)
    #
    # example: AutomationHelpers.log_path = 'automation_helpers.log' would save all
    # log messages to `./automation_helpers.log`
    def log_path=(logdev)
      logger.reopen(logdev)
    end

    # To enable full logging (This uses the Ruby API, so can accept any of a
    # Symbol / String / Integer as an input
    #   AutomationHelpers.log_level = :DEBUG
    #   AutomationHelpers.log_level = 'DEBUG'
    #   AutomationHelpers.log_level = 0
    #
    # To disable all logging (Done by default)
    #   AutomationHelpers.log_level = :UNKNOWN
    def log_level=(value)
      logger.level = value
    end

    # To query what level is being logged
    #   AutomationHelpers.log_level
    #   => :UNKNOWN # By default
    def log_level
      %i[DEBUG INFO WARN ERROR FATAL UNKNOWN][logger.level]
    end
  end
end
