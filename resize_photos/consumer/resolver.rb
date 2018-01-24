require_relative "../init"
require_relative "image"
require_relative "../model/image"

module Consumer
  class Resolver
    def resolve
      response = image_consumer.call

      if response.success?
        response.json["images"].each do |image|
          ::Model::Image.save_from_url(image["url"])
        end
      end
    end

    private

    def image_consumer
      Image.new
    end
  end
end

Consumer::Resolver.new.resolve unless ENV["RACK_ENV"] == "test"
