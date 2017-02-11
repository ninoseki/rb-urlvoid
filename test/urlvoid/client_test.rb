require "test_helper"

describe "URLVoid::Client" do
  before do
    configatron.api_key = "test_key"
    configatron.identifier = "api1000"
    @client = URLVoid::Client.new
  end

  describe "#endpoint" do
    it "should return endpoint URL" do
      @client.endpoint.must_equal "http://api.urlvoid.com/api1000/test_key"
    end
  end

  describe "#query_api" do
    it "should return HTTP response as a Hash" do
      VCR.use_cassette("host-google.com") do
        res = @client.query_api("/host/google.com/")
        res.must_be_instance_of Hash
      end
    end
  end
end
