require_relative "response"
require "net/http"

module Consumer
  class Base
    HOST = "http://54.152.221.29".freeze

    def call
      Response.new(http_response)
    end

    private

    def http_response
      http.request(request)
    end

    def request
      Net::HTTP::Get.new("/#{path}")
    end

    def http
      Net::HTTP.new(uri.host, uri.port)
    end

    def uri
      URI(HOST)
    end
  end
end
