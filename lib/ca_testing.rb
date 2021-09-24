# frozen_string_literal: true

require "ca_testing/drivers"
require "ca_testing/extensions"
require "ca_testing/logger"
require "ca_testing/patches"
require "ca_testing/version"

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
