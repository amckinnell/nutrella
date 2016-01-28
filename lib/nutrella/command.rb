module Nutrella
  class Command
    def initialize(args)
      @options = Options.new(args)
    end

    def run
      @options.parse
      Board.new(@options).open_board unless @options.show_usage?
    rescue OptionParser::InvalidOption => e
      puts e
    end
  end
end
