require 'test_helper'

describe "URLVoid::Stats" do
  before do
    configatron.api_key = "test_key" 
    configatron.identifier = "api1000"
  end

  describe "#self.remained_queries" do
    it "should return HTTP response from /stats/remained as a Integer" do
      VCR.use_cassette("stats-remained") do
        res = URLVoid::Stats.remained_queries
        res.must_be_instance_of Integer
        res.must_equal 986
      end
    end
  end
end
