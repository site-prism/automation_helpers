# frozen_string_literal: true

require "logger"

module CaTesting
  #
  # @api private
  #
  class Logger
    def self.create(output = $stdout)
      logger = ::Logger.new(output)
      logger.progname = "CA Testing Gem"
      logger.level = :INFO
      logger.formatter = proc do |severity, time, progname, msg|
        "#{time.strftime('%F %T')} - #{severity} - #{progname} - #{msg}\n"
      end

      logger
    end
  end
end
