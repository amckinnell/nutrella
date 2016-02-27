module Nutrella
  #
  # This is the top-level class for the gem.
  #
  class Command
    def initialize(configuration_directory)
      @configuration_directory = configuration_directory
    end

    def run
      open_board(TaskBoardName.from_git_branch("."))
    end

    def cache_filename
      File.join(@configuration_directory, ".nutrella.cache.yml")
    end

    def configuration_filename
      File.join(@configuration_directory, ".nutrella.yml")
    end

    private

    def open_board(board_name)
      open_url(board_url(board_name))
    end

    def board_url(board_name)
      url_cache.fetch(board_name) { task_board.lookup_or_create(board_name).try(:url) }
    end

    def open_url(board_url)
      system("open #{board_url}") if board_url
    end

    def task_board
      TaskBoard.new(Configuration.new(configuration_filename))
    end

    def url_cache
      Cache.new(cache_filename, 5)
    end
  end
end
