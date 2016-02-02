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

    # rubocop:disable Metrics/MethodLength
    def dispatch
      case
      when options.init?
        write_default_configuration
        nil
      when options.show_usage?
        puts options.usage
        nil
      when options.show_version?
        puts options.version
        nil
      else
        find_or_create_board
      end
    end
    # rubocop:enable Metrics/MethodLength

    def write_default_configuration
      Configuration.new.write_default if confirm_initialize?
    end

    def confirm_initialize?
      confirm? "Create initial .nutrella.yml configuration? [y/N]: "
    end

    def find_or_create_board
      task_board = TaskBoard.new(options.board_name, Configuration.new)

      existing = task_board.find
      return existing unless existing.nil?

      task_board.create if confirm_create? task_board
    end

    def confirm_create?(task_board)
      confirm? "Create the '#{task_board.name}' task board? [y/N]: "
    end

    def confirm?(prompt)
      print prompt
      gets =~ /^y/i
    end
  end
end
