require "mongo"

module Model
  class Base
    attr_reader :client

    def initialize(client = nil)
      @client ||= Mongo::Client.new(["127.0.0.1:27017"], database: "b2w_#{ENV['RACK_ENV']}")
    end

    def insert(doc)
      collection.insert_one(doc)
    end

    def exists?(filter)
      collection.find(filter).count > 0
    end

    def all
      collection.find
    end

    private

    def collection
      client[collection_name]
    end
  end
end
