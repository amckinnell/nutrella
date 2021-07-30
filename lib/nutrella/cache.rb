# frozen_string_literal: true

require "yaml"

module Nutrella
  #
  # Provides a cache of the most recently used items.
  #
  class Cache
    attr_reader :capacity, :path

    def initialize(path, capacity)
      @path = path
      @capacity = capacity
    end

    def fetch(key)
      value = lookup(key) || yield
      write(key, value)
      value
    end

    def search(search_reg_exp)
      cache_contents.find { |k, _v| search_reg_exp.match?(k) }.last
    rescue
      nil
    end

    private

    def lookup(key)
      cache_contents.find { |k, _v| k == key }.last
    rescue
      nil
    end

    def write(key, value)
      File.write(path, cached_entries(key, value).to_yaml)
    end

    def cached_entries(key, value)
      entries = cache_contents.reject { |k, _v| k == key }

      [[key, value]].concat(entries).take(capacity)
    rescue
      [[key, value]]
    end

    def cache_contents
      @_cache_contents ||= begin
        YAML.load_file(path)
      rescue
        nil
      end
    end
  end
end
