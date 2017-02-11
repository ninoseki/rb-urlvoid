require 'test_helper'
require 'fileutils'

describe "URLVoid::CLI" do
  before do
    @config = File.expand_path("#{Dir.home}/.urlvoid.yml")
    @dummy = File.expand_path("../../fixtures/test.yml", __FILE__)
    FakeFS do
      FakeFS::FileSystem.clone @config
      FakeFS::FileSystem.clone @dummy
      FileUtils.touch @config
    end
    # Reset configatron settings
    configatron.reset!
  end

  describe "#create_config" do
    it "should create a config file if not exists" do
      FakeFS do
        # Delete a config file
        FileUtils.rm @config

        proc { URLVoid::CLI.new.invoke("create_config") }.must_output /has been created/
        File.exist?(@config).must_equal true
      end
    end

    it "should not create a config file if already it exists" do
      FakeFS do
        # Create a config file
        FileUtils.touch @config

        proc { URLVoid::CLI.new.invoke("create_config") }.must_output /is already exists/
      end
    end
  end

  describe "#load_config" do
    it "should load congiguration from a file" do
      URLVoid::CLI.new.load_config @dummy
      configatron.api_key.must_equal "test_key"
      configatron.identifier.must_equal "test_identifier"
    end

    it "should load configuration from ENV variables" do
      ENV["URLVOID_API_KEY"] = "test_key2"
      ENV["URLVOID_IDENTIFIER"] = "test_identifier2"

      FakeFS do
        FileUtils.rm @config

        URLVoid::CLI.new.load_config
        configatron.api_key.must_equal "test_key2"
        configatron.identifier.must_equal "test_identifier2"
      end
    end
  end

  describe "#info" do
    before do
      FakeFS { FileUtils.rm @config }
    end

    it "should output a HTTP response as a JSON" do
      ENV["URLVOID_API_KEY"] = "test_key"
      ENV["URLVOID_IDENTIFIER"] = "api1000"
      VCR.use_cassette("host-google.com") do
        FakeFS do
          out = capture_io { URLVoid::CLI.new.invoke("info", ["google.com"]) }
          # IO output returns as an Array
          JSON.parse(out.first).must_be_instance_of Hash
        end
      end
    end

    it "should output an error message if a config doesn't exist" do
      ENV.delete "URLVOID_API_KEY"
      ENV.delete "URLVOID_IDENTIFIER"
      FakeFS do
        proc { URLVoid::CLI.new.invoke("info", ["google.com"]) }.must_output /Missing API key/
      end
    end
  end
end
