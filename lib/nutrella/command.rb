module Nutrella
  class Command
    def initialize(args)
      @options = Options.new(args)
    end

    def run
      @options.parse
      find_or_create_task_board unless @options.show_usage?
    rescue OptionParser::InvalidOption => e
      puts e
    end

    private

    def find_or_create_task_board
      task_board = TaskBoard.new(@options)

      if task_board.exists?
        task_board.find
      elsif confirm_create? task_board
        task_board.create
      end
    end

    def confirm_create?(board)
      print "Create the '#{board.name}' task board? [y/N]: "
      gets =~ /^y/i
    end
  end
end
