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

    def run
      system("open #{task_board.url}") if task_board.respond_to? :url
    end

    def task_board
      process_options
      find_or_create_board
    rescue
      abort "Error: invalid option: #{@args}"
    end

    private

    def process_options
      OptionParser.new do |opts|
        opts.on("-g", "--current-git-branch", "Open the board matching the current git branch")
        opts.on("-t", "--trello-board BOARD", "Open the board with name BOARD") { |n| @board_name = n }
        opts.on("--init", "Initialize the nutrella.yml configuration") { Configuration.new.write_default; exit }
        opts.on("-v", "--version", "Display the version") { puts Nutrella::VERSION; exit }
        opts.on("-h", "--help", "Display this screen") { puts opts; exit }
      end.parse!(@args)
    end

    def find_or_create_board
      task_board = TaskBoard.new(board_name, Configuration.new)
      board = task_board.find
      return board if board

      task_board.create if confirm_create?(task_board)
    end

    def board_name
      @board_name || trello_board_name_derived_from_git_branch
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
