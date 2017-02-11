# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rb-urlvoid/version'

Gem::Specification.new do |spec|
  spec.name          = "rb-urlvoid"
  spec.version       = URLVoid::VERSION
  spec.authors       = ["ninoseki"]
  spec.email         = ["zgok0079@gmail.com"]

  spec.summary       = "Yet another ruby gem for URLVoid API"
  spec.description   = "Yet another ruby gem for URLVoid API"
  spec.homepage      = "https://github.com/ninoseki/rb-urlvoid"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "fakefs"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  spec.add_dependency "activesupport"
  spec.add_dependency "configatron"
  spec.add_dependency "rest-client"
  spec.add_dependency "thor"
end
