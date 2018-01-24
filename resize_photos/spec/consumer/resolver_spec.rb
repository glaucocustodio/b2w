require_relative "../../consumer/resolver"
require_relative "../../consumer/image"
require_relative "../../model/image"

describe Consumer::Resolver do
  describe "#resolve" do
    let(:consumer_image) { double(:consumer_image) }

    before do
      expect(Consumer::Image).to receive(:new).and_return(consumer_image)
      expect(consumer_image).to receive(:call).and_return(response)
    end

    context "successful response" do
      let(:response) do
        double(
          :response,
          success?: true,
          json: {
            "images" => [
              { "url" => "http://foo.com/images/b737_5.jpg" },
              { "url" => "http://foo.com/images/b777_5.jpg" },
            ]
          }
        )
      end

      before do
        expect(Model::Image).to receive(:save_from_url).with("http://foo.com/images/b737_5.jpg")
        expect(Model::Image).to receive(:save_from_url).with("http://foo.com/images/b777_5.jpg")
      end

      it { subject.resolve }
    end

    context "unsuccessful response" do
      let(:response) { double(:response, success?: false) }
      it { subject.resolve }
    end
  end
end
