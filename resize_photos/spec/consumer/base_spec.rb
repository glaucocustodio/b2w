require_relative "../../consumer/response"
require_relative "../../consumer/base"
require "webmock/rspec"

describe Consumer::Base do
  describe "#call" do
    before do
      expect(subject).to receive(:path).and_return("foo")
      stub_request(:get, "#{Consumer::Base::HOST}/foo")
      expect(Consumer::Response).to receive(:new).with(an_instance_of(Net::HTTPOK))
    end

    it { subject.call }
  end
end
