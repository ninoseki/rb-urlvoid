module URLVoid
  class Client

    attr_reader :api_key, :identifier

    def initialize
      raise URLVoidError, "API key not found" unless configatron.key?("api_key")
      @api_key = configatron.api_key
      @identifier = configatron.identifier
    end

    # URLVoid API endpoint URL
    #
    # @return [String] Endpoint URL
    def endpoint
      "http://api.urlvoid.com/#{identifier}/#{api_key}"
    end

    # Handling HTTP request that raise an exception
    #
    # @raise URLVoidError
    # @yield Give a block that handling HTTP request error
    def with_http_error_handling
      yield
    rescue RestClient::ExceptionWithResponse => e
      raise URLVoidError, e.message
    end

    # Send a query to URLVoid API
    #
    # @param [String] path URL path
    # @return [Hash] Parsed response
    def query_api(path)
      with_http_error_handling do
        res = RestClient.get(endpoint + path)
        h = Hash.from_xml(res.body)
        h["response"]
      end
    end

    # Send a query to URLVoid API
    #
    # @param [String] path URL path
    # @return [Hash] Parsed response
    def self.query_api(path)
      new.query_api path
    end
  end
end
