require "git"
require "optparse"

module Nutrella
  #
  # This is the top-level class for the gem.
  #
  class Command
    def run(args)
      if args.blank?
        find_or_create_board_from_git_branch
        return
      end

      OptionParser.new do |opts|
        opts.on("-t", "--trello-board BOARD", "Open the board with name BOARD") { |n| find_board_by_name(n) }
        opts.on("--init", "Initialize the nutrella.yml configuration") { Configuration.new.write_default }
        opts.on("-v", "--version", "Display the version") { puts Nutrella::VERSION }
        opts.on("-h", "--help", "Display this screen") { puts opts }
      end.parse!(args)
    rescue OptionParser::InvalidOption
      abort "Error: invalid option: #{args}"
    end

    private

    def find_or_create_board_from_git_branch
      board = find_or_create_board(trello_board_name_derived_from_git_branch)
      open_url(board)
    end

    def find_or_create_board(board_name)
      task_board(board_name).find || task_board(board_name).create
    end

    def find_board_by_name(board_name)
      board = find_board(board_name)
      open_url(board)
    end

    def open_url(board)
      system("open #{board.url}") if board.respond_to?(:url)
    end

    def find_board(board_name)
      task_board(board_name).find
    end

    def trello_board_name_derived_from_git_branch
      Git.open(".").current_branch.humanize.titleize
    end

    def task_board(board_name)
      @cached_task_board ||= TaskBoard.new(board_name, Configuration.new)
    end
  end
end
