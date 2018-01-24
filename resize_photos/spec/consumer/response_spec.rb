require_relative "../../consumer/response"

describe Consumer::Response do
  subject { described_class.new(http_response) }

  describe "#success?" do
    context "false" do
      let(:http_response) { double(:http_response, code: "500") }
      it { expect(subject.success?).to eq(false) }
    end

    context "true" do
      let(:http_response) { double(:http_response, code: "200") }
      it { expect(subject.success?).to eq(true) }
    end
  end

  describe "#json" do
    let(:http_response) { double(:http_response, body: '{"images":[{"url":"http://foo.com"}]}') }
    it do
      expect(subject.json).to eq(
        {
          "images" => [{ "url" => "http://foo.com" }]
        }
      )
    end
  end
end
