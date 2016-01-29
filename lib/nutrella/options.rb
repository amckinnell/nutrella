require "git"
require "optionparser"
require "ostruct"
require "active_support/core_ext/string"

class Options
  def initialize(args)
    @args = args
    @options = OpenStruct.new(show_usage: false)
  end

  def parse
    OptionParser.new do |opts|
      opts.on("-t", "--trello-board BOARD", "Open the Trello Board with name BOARD") do |t|
        @options.board_name = t
      end

      opts.on("-h", "--help", "Display this screen") do
        puts(opts)
        @options.show_usage = true
      end
    end.parse!(@args)
  end

  def board_name
    @options.board_name || trello_board_name_derived_from_git_branch
  end

  def show_usage?
    @options.show_usage
  end

  private

  def trello_board_name_derived_from_git_branch
    Git.open(".").current_branch.humanize.titleize
  end
end
