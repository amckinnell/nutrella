require "git"
require "optionparser"
require "ostruct"

class Options
  def initialize(args)
    @args = args
    @options = OpenStruct.new
  end

  def parse
    OptionParser.new do |opts|
      opts.on("-t", "--trello-board BOARD", "Open the Trello Board with name BOARD") do |t|
        @options.board_name = t
      end

      opts.on("-h", "--help", "Display this screen") do
        puts(opts)
        return false
      end
    end.parse!(@args)

    true
  end

  def board_name
    @options.board_name || git_branch_name
  end

  private

  def git_branch_name
    Git.open(".").current_branch
  end
end
