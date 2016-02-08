module Nutrella
  #
  # This is the top-level class for the gem.
  #
  class Command
    def initialize
      @cache = Cache.new
    end

    def run
      open_board_for_git_branch
    end

    private

    def open_board_for_git_branch
      board_name = TaskBoardName.current_git_branch
      open_url(lookup(board_name) || create(board_name))
    end

    def open_url(board_url)
      system("open #{board_url}") if board_url
    end

    def create(board_name)
      @cache.put(board_name) { task_board.create(board_name) }
    end

    def lookup(board_name)
      @cache.get(board_name) { task_board.lookup(board_name) }
    end

    def task_board
      @cached_task_board ||= TaskBoard.new(Configuration.new)
    end
  end
end
