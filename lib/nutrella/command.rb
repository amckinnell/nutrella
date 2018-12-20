# frozen_string_literal: true

module Nutrella
  #
  # This is the top-level class for the gem.
  #
  class Command
    attr_reader :cache_filename, :configuration_filename

    def initialize(configuration_directory, board_name)
      @board_name = board_name
      @cache_filename = File.join(configuration_directory, ".nutrella.cache.yml")
      @configuration_filename = File.join(configuration_directory, ".nutrella.yml")
    end

    def run
      open board_url # rubocop:disable Security/Open
    end

    private

    def board_url
      url_cache.fetch(@board_name) { task_board.lookup_or_create(@board_name).url }
    end

    def open(url)
      system("open #{url}")
    end

    def task_board
      Nutrella::TaskBoard.new(Nutrella::Configuration.values(configuration_filename))
    end

    def url_cache
      Nutrella::Cache.new(cache_filename, 5)
    end
  end
end
