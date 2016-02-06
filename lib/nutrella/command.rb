require "git"
require "optparse"

module Nutrella
  #
  # This is the top-level class for the gem.
  #
  class Command
    def run(args)
      if args.blank?
        open_board_for_git_branch
        return
      end

      OptionParser.new do |opts|
        opts.on("-t", "--trello-board BOARD", "Open the board with name BOARD") { |name| open_board(name) }
        opts.on("--init", "Initialize the nutrella.yml configuration") { Configuration.new.write_default }
        opts.on("-v", "--version", "Display the version") { puts Nutrella::VERSION }
        opts.on("-h", "--help", "Display this screen") { puts opts }
      end.parse!(args)
    rescue OptionParser::InvalidOption
      abort "Error: invalid option: #{args}"
    end

    private

    def open_board_for_git_branch
      board_name = board_name_from_git_branch
      open_url(find(board_name) || create(board_name))
    end

    def open_board(board_name)
      open_url(find(board_name))
    end

    def open_url(board)
      system("open #{board.url}") if board.respond_to?(:url)
    end

    def board_name_from_git_branch
      Git.open(".").current_branch.humanize.titleize
    end

    def find(board_name)
      task_board.find(board_name)
    end

    def create(board_name)
      task_board.create(board_name)
    end

    def task_board
      @cached_task_board ||= TaskBoard.new(Configuration.new)
    end
  end
end
