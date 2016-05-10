$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
require "coveralls"

SimpleCov.formatters = [
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
    
]
SimpleCov.start do
  add_filter 'spec'
end

require 'dotenv'
require 'faker'
require 'vcr'
require 'webmock/rspec'

require 'ConnectedDriveAPI'

Dotenv.load

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock
  c.default_cassette_options = {:record => :new_episodes}
  c.configure_rspec_metadata!

  c.define_cassette_placeholder("<BMW_CLIENT_ID>", ENV["BMW_CLIENT_ID"])
  c.define_cassette_placeholder("<BMW_USER>", ENV["BMW_USER"])
  c.define_cassette_placeholder("<BMW_PASSWORD>", ENV["BMW_PASSWORD"])
  c.define_cassette_placeholder("<VIN>", Faker::Lorem.characters(16))
  c.define_cassette_placeholder("<REG>", Faker::Lorem.characters(7))
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!
  config.order = :random
  Kernel.srand config.seed
end