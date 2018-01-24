require_relative "../../processor/image"
require "webmock/rspec"

describe Processor::Image do
  subject { described_class.new(url) }
  let(:url) { "http://54.152.221.29/images/b737_5.jpg" }
  let(:image) { double(:image) }

  before do
    expect(MiniMagick::Image).to receive(:open).with(url).and_return(image)
  end

  describe "#resize" do
    before do
      expect(image).to receive(:resize).with("200x200")
      expect(subject).to receive(:save).with("200x200_b737_5.jpg").and_return("200x200_b737_5.jpg")
    end

    it { expect(subject.resize("200x200")).to eq("200x200_b737_5.jpg") }
  end
end
