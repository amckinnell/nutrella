module Nutrella
  class Command
    def initialize(args)
      @args = args
    end

    def run
      o = Options.new(@args)

      o.parse && puts("Board name: #{o.board_name}")
    end
  end
end
