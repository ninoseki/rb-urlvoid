module URLVoid
  class Stats
    # Get the number of queries remained
    #
    # @return [Integer] Response as an Integer
    def self.remained_queries
      res = Client.query_api("/stats/remained/")
      res["queriesRemained"].to_i
    end
  end
end
