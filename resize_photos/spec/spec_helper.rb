require "mongo"

Mongo::Logger.logger.level = Logger::WARN

ENV['RACK_ENV'] = 'test'
