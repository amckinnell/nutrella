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
      launch(board_url)
    ensure
      logger.close
    end

    private

    def launch(url)
      launch_command = configuration_values.fetch(:launch_command).gsub("$url$", url)

      logger.info { "Launch command: '#{launch_command}'" }

      system(launch_command)
    end

    def board_url
      url = enable_trello_app? ? trello_url(cached_url) : cached_url

      logger.info { "Board URL: '#{url}'" }

      url
    end

    def cache_capacity
      @_cache_capacity ||= configuration_values.fetch(:cache_capacity)
    end

    def cached_url
      @_cached_url ||= url_cache.fetch(@board_name) { task_board.lookup_or_create(@board_name).url }
    end

    def configuration_values
      @_configuration_values ||= Nutrella::Configuration.values(configuration_filename)
    end

    def enable_trello_app?
      configuration_values.fetch(:enable_trello_app)
    end

    def logger
      @_logger ||= Logger.new(log_filename)
    end

    def log_filename
      configuration_values.fetch(:enable_logging) ? "nutrella.log" : "/dev/null"
    end

    def trello_url(http_url)
      http_url.gsub(/^http.?:/, "trello:")
    end

    def task_board
      Nutrella::TaskBoard.new(configuration_values)
    end

    def url_cache
      Nutrella::Cache.new(cache_filename, cache_capacity)
    end
  end
end
