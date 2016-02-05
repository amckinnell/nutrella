require "git"
require "optparse"

module Nutrella
  #
  # Knows how to dispatch to a command based on the specified options.
  #
  class Command
    attr_reader :options

    def initialize(args)
      @args = args
    end

    def task_board
      boardname = nil

      OptionParser.new do |opts|
        opts.on("-g", "--current-git-branch", "Open the board matching the current git branch")
        opts.on("-t", "--trello-board BOARD", "Open the board with name BOARD") { |n| boardname = n }
        opts.on("--init", "Initialize the nutrella.yml configuration") { |n| Configuration.new.write_default; exit }
        opts.on("-v", "--version", "Display the version") { |n| puts Nutrella::VERSION; exit }
        opts.on("-h", "--help", "Display this screen") { |n| puts opts; exit }
      end.parse!(@args)

      find_or_create_board(boardname || trello_board_name_derived_from_git_branch)
    rescue => e
      abort "Error: invalid option: #{@args}"
    end

    private

    def find_or_create_board(board_name)
      task_board = TaskBoard.new(board_name, Configuration.new)
      board = task_board.find
      return board if board

      task_board.create if confirm_create?(task_board)
    end

    def confirm_create?(task_board)
      print "Create the '#{task_board.name}' task board? [y/N]: "
      gets =~ /^y/i
    end

    def trello_board_name_derived_from_git_branch
      Git.open(".").current_branch.humanize.titleize
    end
  end
end
