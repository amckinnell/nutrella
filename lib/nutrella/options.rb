require "git"
require "optionparser"
require "ostruct"
require "active_support/core_ext/string"

class Options
  def initialize(args)
    @args = args
    @options = OpenStruct.new
  end

  # rubocop:disable Metrics/MethodLength
  def parse
    OptionParser.new do |opts|
      opts.on("-g", "--current-git-branch", "Open the board matching the current git branch")

      opts.on("--init", "Initialize the nutrella.yml configuration") do
        @options.init = true
      end

      opts.on("-t", "--trello-board BOARD", "Open the board with name BOARD") do |t|
        @options.board_name = t
      end

      opts.on("-h", "--help", "Display this screen") do
        @options.usage = opts
      end
    end.parse!(@args)
  end
  # rubocop:enable Metrics/MethodLength

  def board_name
    @options.board_name || trello_board_name_derived_from_git_branch
  end

  def init?
    @options.init
  end

  def show_usage?
    usage.present?
  end

  def usage
    @options.usage
  end

  private

  def trello_board_name_derived_from_git_branch
    Git.open(".").current_branch.humanize.titleize
  end
end
