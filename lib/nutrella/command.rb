module Nutrella
  #
  # Knows how to dispatch to a command based on the specified options.
  #
  class Command
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def task_board
      options.parse
      dispatch
    rescue => e
      puts "Error: #{e}"
      exit(false)
    end

    private

    def dispatch
      case
      when options.init?
        write_default_configuration
      when options.show_usage?
        puts options.usage
      when options.show_version?
        puts options.version
      else
        task_board_url
      end
    end

    def write_default_configuration
      Configuration.new.write_default
    end

    def task_board_url
      (cached_url || find_or_create_board).tap do |board|
        Cache.write(options.board_name, board.url) unless board.nil?
      end
    end

    def cached_url
      url = Cache.lookup(options.board_name)

      url && OpenStruct.new(url: url)
    end

    def find_or_create_board
      task_board = TaskBoard.new(options.board_name, Configuration.new)

      existing = task_board.find
      return existing unless existing.nil?

      task_board.create if confirm_create? task_board
    end

    def confirm_create?(task_board)
      print "Create the '#{task_board.name}' task board? [y/N]: "
      gets =~ /^y/i
    end
  end
end
