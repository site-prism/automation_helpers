# frozen_string_literal: true
require "ca_testing/drivers"
require "ca_testing/version"

module CaTesting
  autoload :Logger, 'ca_testing/logger'

  class << self
    def configure
      yield self
    end

    def logger
      @logger ||= CaTesting::Logger.new.create
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
