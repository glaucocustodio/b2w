require_relative "../../api/main"
require "rack/test"

describe "/" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  let(:json_response) { JSON.parse(last_response.body) }
  let(:model_image) { double(:model_image) }
  let(:fake_date) do
    [
      { "small" => "a.jpg", "medium" => "b.jpg", "large" => "c.jpg" }
    ]
  end

  before do
    expect(Model::Image).to receive(:new).and_return(model_image)
    expect(model_image).to receive(:all).and_return(fake_date)

    get "/"
  end

  it do
    expect(last_response).to be_ok
    expect(last_response.content_type).to eq("application/json")

    expect(json_response).to eq([
      {
        "small" => "a.jpg", "small_url" => "http://example.org/a.jpg",
        "medium" => "b.jpg", "medium_url" => "http://example.org/b.jpg",
        "large" => "c.jpg", "large_url" => "http://example.org/c.jpg"
      }
    ])
  end
end
