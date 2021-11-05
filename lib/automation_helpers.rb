# frozen_string_literal: true

require "automation_helpers/drivers"
require "automation_helpers/extensions"
require "automation_helpers/logger"
require "automation_helpers/patches"
require "automation_helpers/version"

module CaTesting
  class << self
    attr_accessor :chrome_log_path

    def configure
      yield self
    end

    def logger
      @logger ||= Logger.create
    end

    def logger=(logger)
      raise ArgumentError, "You must supply an existing Logger" unless logger.is_a?(::Logger)

      @logger = logger
    end

    def log_path=(logdev)
      logger.reopen(logdev)
    end

    def log_level=(value)
      logger.level = value
    end

    def log_level
      %i[DEBUG INFO WARN ERROR FATAL UNKNOWN][logger.level]
    end
  end
end
