module Nutrella
  class Command
    def initialize(args)
      @options = Options.new(args)
    end

    def run
      puts "Board name: #{@options.board_name}" if @options.parse
    rescue OptionParser::InvalidOption => e
      puts e
    end
  end
end
