module URLVoid
  class Host

    # Retrieve information about a specific website
    #
    # @return [Hash] Parsed response
    def self.info(host_name)
      res = Client.query_api("/host/#{host_name}/")
      return res unless res.key?("detections")

      # if "detections" key exists, refill "engines" values as an Array
      engines = res["detections"]["engines"].values.flatten
      res["detections"]["engines"] = engines
      res
    end

    # Rescan of a specific website
    #
    # @return [Hash] Parsed response
    def self.rescan(host_name)
      Client.query_api("/host/#{host_name}/rescan/")
    end

    # Scan a new website not present in the URLVoid's database
    #
    # @return [Hash] Parsed response
    def self.new_scan(host_name)
      Client.query_api("/host/#{host_name}/newscan/")
    end
  end
end
