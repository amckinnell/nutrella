require "yaml"

module Nutrella
  #
  # Provides a cache of the most recently accessed items.
  #
  class Cache
    CACHE_FILENAME = ".nutrella.cache.yml"
    CACHE_CAPACITY = 5

    def get(key)
      value = lookup(key) || yield
      update(key, value)
    end

    def put(key)
      value = yield
      update(key, value)
    end

    private

    def lookup(key)
      YAML.load_file(path).find { |k, _v| k == key }.last
    rescue
      nil
    end

    def update(key, value)
      write(key, value) unless value.nil?
      value
    end

    def write(key, value)
      File.write(path, cached_entries(key, value).to_yaml)
    end

    def cached_entries(key, value)
      entries = YAML.load_file(path).reject { |k, _v| k == key }

      [[key, value]].concat(entries).take(CACHE_CAPACITY)
    rescue
      [[key, value]]
    end

    def path
      "#{Dir.home}/#{CACHE_FILENAME}"
    end
  end
end
