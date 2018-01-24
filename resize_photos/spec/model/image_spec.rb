require_relative "../../model/image"

describe Model::Image do
  describe ".save_from_url" do
    let(:image_processor) { double(:image_processor) }
    let(:subject_instance) { double(:subject_instance) }

    before do
      expect(Processor::Image).to receive(:new).with("http://foo.com").and_return(image_processor)
      expect(image_processor).to receive(:resize).with("640x480").and_return("640x480.jpg")
      expect(image_processor).to receive(:resize).with("384x288").and_return("384x288.jpg")
      expect(image_processor).to receive(:resize).with("320x240").and_return("320x240.jpg")
      expect(described_class).to receive(:new).and_return(subject_instance)
      expect(subject_instance).to receive(:insert).with({
        original_url: "http://foo.com",
        small: "320x240.jpg",
        medium: "384x288.jpg",
        large: "640x480.jpg"
      })
    end

    it { described_class.save_from_url("http://foo.com") }
  end

  describe "#all" do

    before do
      subject.client.database.drop

      subject.insert({ "small" => "s1.jpg" })
      subject.insert({ "small" => "s2.jpg" })
    end

    it do
      expect(subject.all).to eq(
        [
          { "small" => "s1.jpg" },
          { "small" => "s2.jpg" }
        ]
      )
    end
  end
end
