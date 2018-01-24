require "json"

module Consumer
  class Response
    SUCCESS_CODE = "200".freeze

    def initialize(http_response)
      @http_response = http_response
    end

    def success?
      http_response.code == SUCCESS_CODE
    end

    def json
      JSON.parse(http_response.body)
    end

    private

    attr_reader :http_response
  end
end
