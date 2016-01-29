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
      board = Board.new(@options)

      if board.find_board
        open_trello_board board.find_board
      elsif confirm_create? board
        open_trello_board board.create_board
      end
    end

    def confirm_create?(board)
      print "Create the '#{board.name}' board? [y/N]: "
      gets =~ /^y/i
    end

    def open_trello_board(board)
      system "open #{board.url}"
    end
  end
end
