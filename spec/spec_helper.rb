require "simplecov"
SimpleCov.start

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "nutrella"

require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "vcr_cassettes"
  config.hook_into :webmock

  # Use a VCR cassette for any RSpec example tagged with `:vcr`.
  config.configure_rspec_metadata!
end
