module Nutrella
  #
  # This is the top-level class for the gem.
  #
  class Command
    def initialize(configuration_path)
      @url_cache = Cache.new
      @configuration_path = configuration_path
    end

    def run
      open_board(TaskBoardName.current_git_branch)
    end

    private

    def open_board(board_name)
      open_url(board_url(board_name))
    end

    def board_url(board_name)
      @url_cache.fetch(board_name) { lookup(board_name) || create(board_name) }
    end

    def open_url(board_url)
      system("open #{board_url}") if board_url
    end

    def lookup(board_name)
      task_board.lookup(board_name).try(:url)
    end

    def create(board_name)
      task_board.create(board_name).try(:url)
    end

    def task_board
      @cached_task_board ||= TaskBoard.new(Configuration.new(@configuration_path))
    end
  end
end
