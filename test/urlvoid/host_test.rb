require 'test_helper'

describe "URLVoid::Host" do
  before do
    configatron.api_key = "test_key"
    configatron.identifier = "api1000"
  end

  describe "#self.into" do
    it "should return HTTP response from /host/google.com as a Hash" do
      VCR.use_cassette("host-google.com") do
        res = URLVoid::Host.info("google.com")
        res.must_be_instance_of Hash
        res["details"]["host"].must_equal "google.com"
        res["details"]["ip"]["addr"].must_equal "216.58.204.110"
        res["detections"].must_be_nil
      end
    end

    it "should return HTTP response from /host/auracinematics.com as a Hash" do
      VCR.use_cassette("host-auracinematics.com") do
        res = URLVoid::Host.info "auracinematics.com"
        res["details"]["host"].must_equal "auracinematics .com"
        res["details"]["ip"]["addr"].must_equal "204.11.59. 216"
        res["detections"]["engines"].length.must_equal 8
        res["detections"]["count"].must_equal "8"
      end
    end
  end

  describe "#self.rescan" do
    it "should return HTTP response from /host/google.com/rescan/ as a Hash" do
      VCR.use_cassette("rescan-host-google.com") do
        res = URLVoid::Host.rescan("google.com")
        res.must_be_instance_of Hash
        res["details"]["host"].must_equal "google.com"
        res["action_result"].must_equal "OK"
      end
    end
  end

  describe "#self.new_scan" do
    it "should return HTTP response from /host/google.com/newscan/ as a Hash" do
      VCR.use_cassette("newscan-host-google.com") do
        res = URLVoid::Host.new_scan("google.com")
        res.must_be_instance_of Hash
        res["page_load"].wont_be_nil
      end
    end
  end
end
