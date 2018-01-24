require_relative "../../consumer/image"

describe Consumer::Image do
  describe "#path" do
    it { expect(subject.path).to eq("images.json") }
  end
end
