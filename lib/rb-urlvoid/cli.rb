module URLVoid
  class CLI < Thor

    # Default path to the config file
    #
    # @return [String] Default path to the config file
    CONFIG_FILE = "#{Dir.home}/.urlvoid.yml".freeze

    # Retrieve information about a specific website
    #
    # @param host_name [String] Host name
    desc "info HOST_NAME", "Retrieve information about a specific website"
    def info(host_name)
      with_load_config { puts JSON.pretty_generate(Host.info(host_name)) }
    end

    # Update the report of a specific website
    #
    # @param host_name [String] Host name
    desc "rescan HOST_NAME", "Update the report of a specific website"
    def rescan(host_name)
      with_load_config { puts JSON.pretty_generate(Host.rescan(host_name)) }
    end

    # Scan a new website not present in the database
    #
    # @param host_name [String] Host name
    desc "new_scan HOST_NAME", "Scan a new website not present in the database"
    def new_scan(host_name)
      with_load_config { puts JSON.pretty_generate(Host.new_scan(host_name)) }
    end

    # Get the number of queries remained
    desc "stats", "Get the number of queries remained"
    def stats
      with_load_config { puts "Remained queries: #{Stats.remained_queries}" }
    end

    # Create a config file
    #
    # @param file [String] Path to the config file
    desc "create_config", "Create a config file"
    def create_config(file = CONFIG_FILE)
      path = File.expand_path(file)
      if File.exist?(path)
        puts "[!] #{path} is already exists. Please delete it if you want to re-create it."
      else
        h = { api_key: "INSERT YOUR API KEY", identifier: "api1000" }
        YAML.dump h, File.open(path, "w+")
        puts "[*] An empty #{path} has been created. Please edit and fill the correct values."
      end
    end

    no_commands do
      # Load a config file
      #
      # @note Configuration params are set as configatron attributes
      # @param file [String] Path to the config file
      def load_config(file = CONFIG_FILE)
        path = File.expand_path(file)
        if File.exist?(path)
          h = YAML.load_file(path)
        elsif ENV["URLVOID_API_KEY"]
          h = { api_key: ENV["URLVOID_API_KEY"], identifier: ENV["URLVOID_IDENTIFIER"] || "api1000" }
        else
          raise URLVoidError, "[!] Missing API key: Create a config file or specify it via ENV variable"
        end
        configatron.configure_from_hash h
      end

      # Handling a method which needs config parameters
      #
      # @yield Give a block that pre-loaded a config file
      def with_load_config
        load_config
        yield
      rescue URLVoidError => e
        puts e
      end
    end
  end
end
