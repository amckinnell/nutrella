require "yaml"

module Nutrella
  #
  # Knows how to cache the URL for a task board.
  #
  module Cache
    module_function

    CACHE_FILENAME = ".nutrella.cache.yml".freeze
    CACHE_CAPACITY = 5

    def lookup(board_name)
      YAML.load_file(path).find { |board, _url| board == board_name }.last
    rescue
      nil
    end

    def write(board_name, url)
      entries = cached_entries(board_name, url)

      File.open(path, "w") { |f| f.write entries.to_yaml }
    end

    def cached_entries(board_name, url)
      entries = YAML.load_file(path).reject { |board, _url| board == board_name }

      [[board_name, url]].concat(entries).take(CACHE_CAPACITY)
    rescue
      [[board_name, url]]
    end

    def path
      "#{Dir.home}/#{CACHE_FILENAME}"
    end
  end
end
