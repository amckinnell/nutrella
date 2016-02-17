require "yaml"

module Nutrella
  #
  # Provides a cache of the most recently used items.
  #
  class Cache
    CACHE_FILENAME = ".nutrella.cache.yml"

    attr_reader :capacity, :path

    def initialize(configuration_directory, capacity)
      @path = File.join(configuration_directory, CACHE_FILENAME)
      @capacity = capacity
    end

    def fetch(key)
      value = lookup(key) || yield
      write(key, value)
      value
    end

    private

    def lookup(key)
      YAML.load_file(path).find { |k, _v| k == key }.last
    rescue
      nil
    end

    def write(key, value)
      File.write(path, cached_entries(key, value).to_yaml) unless value.nil?
    end

    def cached_entries(key, value)
      entries = YAML.load_file(path).reject { |k, _v| k == key }

      [[key, value]].concat(entries).take(capacity)
    rescue
      [[key, value]]
    end
  end
end
