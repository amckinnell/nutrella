module Nutrella
  class Command
    def initialize(args)
      @options = Options.new(args)
    end

    def run
      @options.parse
      open_board unless @options.show_usage?
    rescue OptionParser::InvalidOption => e
      puts e
    end

    private

    def open_board
      task_board = TaskBoard.new(@options)

      if task_board.find
        open_trello_board task_board.find
      elsif confirm_create? task_board
        open_trello_board task_board.create
      end
    end

    def confirm_create?(board)
      print "Create the '#{board.name}' task board? [y/N]: "
      gets =~ /^y/i
    end

    def open_trello_board(board)
      system "open #{board.url}"
    end
  end
end
