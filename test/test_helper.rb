$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'urlvoid'

require 'minitest/spec'
require 'minitest/autorun'
require 'webmock/minitest'
require 'fakefs/safe'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "test/fixtures"
  c.hook_into :webmock
end
