module Nutrella
  #
  # Knows how to dispatch to a command based on the specified options.
  #
  class Command
    def initialize(args)
      @options = Options.new(args)
    end

    def task_board
      @options.parse
      dispatch
    rescue StandardError => e
      puts "Error: #{e}"
      exit(false)
    end

    private

    # rubocop:disable Metrics/MethodLength
    def dispatch
      case
      when @options.show_usage?
        puts @options.usage
        nil
      when @options.init?
        write_default_configuration if confirm_initialize?
        nil
      when @options.show_version?
        puts @options.version
        nil
      else
        find_or_create_task_board
      end
    end
    # rubocop:enable Metrics/MethodLength

    def write_default_configuration
      Configuration.write_default
    end

    def confirm_initialize?
      confirm? "Create initial .nutrella.yml configuration? [y/N]: "
    end

    def find_or_create_task_board
      task_board = TaskBoard.new(@options, Configuration.location)

      if task_board.exists?
        task_board.find
      elsif confirm_create? task_board
        task_board.create
      end
    end

    def confirm_create?(board)
      confirm? "Create the '#{board.name}' task board? [y/N]: "
    end

    def confirm?(prompt)
      print prompt
      gets =~ /^y/i
    end
  end
end
