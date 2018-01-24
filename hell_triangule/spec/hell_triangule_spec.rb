require_relative '../hell_triangule'

describe HellTriangule do
  subject { described_class.new(triangule) }

  describe "#resolve" do
    context "when it is an invalid triangule" do
      let(:triangule) { [] }
      it { expect(subject.resolve).to eq(nil) }
    end

    context "when the triangule has 4 lines" do
      let(:triangule) { [[6], [3,5], [9,7,1], [4,6,8,4]] }
      it { expect(subject.resolve).to eq(26) }
    end

    context "when both values in a line are equal" do
      let(:triangule) { [[6], [3,3], [9,7,1], [4,6,10,4]] }

      it "must choose the first" do
        expect(subject.resolve).to eq(24)
      end
    end

    context "when the triangule has 5 lines" do
      let(:triangule) { [[1], [5,3], [1,7,9], [4,6,10,12], [6,8,1,10,11]] }
      it { expect(subject.resolve).to eq(33) }
    end
  end
end
