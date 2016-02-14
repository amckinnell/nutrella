module Nutrella
  #
  # This is the top-level class for the gem.
  #
  class Command
    def initialize(configuration_path)
      @cache = Cache.new
      @configuration_path = configuration_path
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
      @cache.put(board_name) { task_board.create(board_name).try(:url) }
    end

    def lookup(board_name)
      @cache.get(board_name) { task_board.lookup(board_name).try(:url) }
    end

    def task_board
      @cached_task_board ||= TaskBoard.new(Configuration.new(@configuration_path))
    end
  end
end
