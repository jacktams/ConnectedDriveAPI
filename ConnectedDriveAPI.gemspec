# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ConnectedDriveAPI/version'

Gem::Specification.new do |spec|
  spec.name          = "ConnectedDriveAPI"
  spec.version       = ConnectedDriveAPI::VERSION
  spec.authors       = ["Jack Tams"]
  spec.email         = ["jack@jacktams.co.uk"]

  spec.summary       = %q{Allows interaction with the BMW Connected Drive Webservices API.}
  spec.homepage      = "http://jack.sh"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_dependency "httparty"
  
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "faker", "~> 1.6.3"
  spec.add_development_dependency "vcr", "~> 3.0.1"
  spec.add_development_dependency "webmock", "~> 2.0.1"
  spec.add_development_dependency "dotenv", "~> 2.1.1"
  spec.add_development_dependency "simplecov", "~> 0.11.2"
  spec.add_development_dependency "coveralls", "~> 0.8.3"
end
