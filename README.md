# rb-urlvoid

rb-urlvoid is a yet another [URLVoid](http://www.urlvoid.com/) API gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rb-urlvoid'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install rb-urlvoid
$ urlvoid [options]
```

** Create your configuration file **

```bash
$ urlvoid create_config
```

** Edit your configuration file with API KEY **

```bash
$ $EDITOR ~/.urlvoid.yml
```

** Alternatively you can set Environment variables without a config file **

```bash
$ export URLVOID_API_KEY=<YOUR_API_KEY_HERE>
```

## Usage

** Retrieve information about a specific website **

```bash
$ urlvoid info malicious.com
=>
{
  "details": {
    "host": "malicious.com",
    "updated": "1486047152",
    "http_response_code": "0",
    "domain_age": "808372800",
    "google_page_rank": "0",
    "alexa_rank": "0",
    "connect_time": "0",
    "header_size": "0",
    "download_size": "0",
    "speed_download": "0",
    "external_url_redirect": null,
    "ip": {
      "addr": "93.184.216.34",
      "hostname": null,
      "asn": "15133",
      "asname": "EdgeCast Networks, Inc.",
      "country_code": "US",
      "country_name": "United States",
      "region_name": "Massachusetts",
      "city_name": "Norwell",
      "continent_code": "NA",
      "continent_name": "North America",
      "latitude": "42.1508",
      "longitude": "-70.8228"
    }
  },
  "detections": {
    "engines": [
      "BitDefender",
      "Fortinet"
    ],
    "count": "2"
  },
  "page_load": "0.01"
}
```

** Rescan of a specific website **

```bash
$ urlvoid rescan example.com
=>
{
  "details": {
    "host": "example.com",
    "updated": "1486798381",
    "http_response_code": "0",
    "domain_age": "808372800",
    "google_page_rank": "0",
    "alexa_rank": "0",
    "connect_time": "0",
    "header_size": "0",
    "download_size": "0",
    "speed_download": "0",
    "external_url_redirect": null,
    "ip": {
      "addr": "93.184.216.34",
      "hostname": null,
      "asn": "15133",
      "asname": "EdgeCast Networks, Inc.",
      "country_code": "US",
      "country_name": "United States",
      "region_name": "Massachusetts",
      "city_name": "Norwell",
      "continent_code": "NA",
      "continent_name": "North America",
      "latitude": "42.1508",
      "longitude": "-70.8228"
    }
  },
  "action_result": "OK",
  "page_load": "20.38"
}
```

** Scan a new website not present in the URLVoid's database **

```bash
$ urlvoid new_sacan unkown.com
=>
{
  "page_load": "0.01"
}
```

** Get the number of queries remained **
```
$ urlvoid stats
=> Remained queries: 973
```

## API Usage

```ruby
require 'urlvoid'

# Retrieve information about a specific website
result = URLVoid::Host.info "example.com"
# => Returns API response as a Hash

# Rescan of a specific website
result = URLVoid::Host.rescan "example.com"
# => Returns API response as a Hash

# Scan a new website not present in the URLVoid's database
result = URLVoid::Host.new_scan "example.com"
# => Returns API response as a Hash

# Get the number of queries remained
result = URLVoid::Stats.remained_queries
# => Returns API response as a Integer
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ninoseki/rb-urlvoid. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
