module Nutrella
  class Command
    def initialize(args)
      @options = Options.new(args)
    end

    def run
      success = @options.parse

      puts("Board name: #{@options.board_name}") if success
    end
  end
end
