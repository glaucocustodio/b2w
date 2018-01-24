require_relative "../../model/base"

describe Model::Base do
  let(:collection) { subject.client[:images] }

  before do
    expect(Mongo::Client).to receive(:new).once.and_call_original
    allow(subject).to receive(:collection).and_return(collection)
    subject.client.database.drop
  end

  describe "#insert" do
    it do
      subject.insert({ "small" => "a.jpg" })
      subject.insert({ "small" => "b.jpg" })

      expect(collection.find.count).to eq(2)
      expect(collection.find.to_a.first["small"]).to eq("a.jpg")
      expect(collection.find.to_a.last["small"]).to eq("b.jpg")
    end
  end

  describe "#all" do
    before do
      collection.insert_one({ "a" => "foo" })
    end

    it do
      expect(subject.all.count).to eq(1)
      expect(subject.all.first["a"]).to eq("foo")
    end
  end
end
