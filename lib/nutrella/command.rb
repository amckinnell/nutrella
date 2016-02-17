module Nutrella
  #
  # This is the top-level class for the gem.
  #
  class Command
    def initialize(configuration_directory)
      @url_cache = Cache.new(configuration_directory)
      @task_board = TaskBoard.new(Configuration.new(configuration_directory))
    end

    def run
      open_board(TaskBoardName.current_git_branch)
    end

    private

    def open_board(board_name)
      open_url(board_url(board_name))
    end

    def board_url(board_name)
      @url_cache.fetch(board_name) { @task_board.lookup_or_create(board_name).try(:url) }
    end

    def open_url(board_url)
      system("open #{board_url}") if board_url
    end
  end
end
