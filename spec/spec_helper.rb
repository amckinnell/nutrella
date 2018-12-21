# Right at the top so we don't miss any opportunities to track coverage.
require "simplecov"
SimpleCov.start

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "nutrella"

# Fail specs which run for longer than 2 seconds. Most useful during mutation testing.
require "timeout"
RSpec.configure do |rspec|
  rspec.around do |example|
    Timeout.timeout(2_000, &example)
  end
end
