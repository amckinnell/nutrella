require "git"
require "optionparser"
require "ostruct"

module Nutrella
  class Command
    attr_reader :args

    def initialize(*args)
      @args = args
    end

    def run
      g = Git.open(".")
      puts "Current branch: #{g.current_branch}"

      puts "Options: #{parse(ARGV)}"
    end

    private

    # rubocop:disable Metrics/MethodLength
    def parse(args)
      options = OpenStruct.new

      OptionParser.new do |opts|
        opts.on("-t", "--trello-board BOARD", "Open the Trello Board with name BOARD") do |t|
          options.board_name = t
        end

        opts.on("-h", "--help", "Display this screen") do
          puts(opts)
          exit
        end
      end.parse!(args)

      options
    end
    # rubocop:enable Metrics/MethodLength
  end
end
