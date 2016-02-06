require "git"
require "optparse"

module Nutrella
  #
  # This is the top-level class for the gem.
  #
  class Command
    attr_reader :options

    def initialize(args)
      @args = args
    end

    def run
      if @args.blank?
        find_or_create_board_from_git_branch
        return
      end

      OptionParser.new do |opts|
        opts.on("-t", "--trello-board BOARD", "Open the board with name BOARD") { |n| find_board_by_name(n) }
        opts.on("--init", "Initialize the nutrella.yml configuration") { Configuration.new.write_default }
        opts.on("-v", "--version", "Display the version") { puts Nutrella::VERSION }
        opts.on("-h", "--help", "Display this screen") { puts opts }
      end.parse!(@args)
    rescue
      abort "Error: invalid option: #{@args}"
    end

    private

    def find_or_create_board_from_git_branch
      task_board = find_or_create_board(trello_board_name_derived_from_git_branch)
      system("open #{task_board.url}") if task_board.respond_to? :url
    end

    def find_or_create_board(board_name)
      task_board = TaskBoard.new(board_name, Configuration.new)
      board = task_board.find
      return board if board

      task_board.create
    end

    def find_board_by_name(board_name)
      task_board = find_board(board_name)
      system("open #{task_board.url}") if task_board.respond_to? :url
    end

    def find_board(board_name)
      task_board = TaskBoard.new(board_name, Configuration.new)
      task_board.find
    end

    def trello_board_name_derived_from_git_branch
      Git.open(".").current_branch.humanize.titleize
    end
  end
end
