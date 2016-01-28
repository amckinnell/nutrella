module Nutrella
  class Command
    def initialize(args)
      @options = Options.new(args)
    end

    def run
      Board.new(@options).open_board if @options.parse
    rescue OptionParser::InvalidOption => e
      puts e
    end
  end
end
