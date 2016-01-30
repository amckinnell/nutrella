module Nutrella
  class Command
    def initialize(args)
      @options = Options.new(args)
    end

    def task_board
      @options.parse
      dispatch
    rescue OptionParser::InvalidOption => e
      puts e
    end

    private

    def dispatch
      case
      when @options.show_usage?
        puts @options.usage
        nil
      when @options.init?
        initialize_nutrella_configuration if confirm_initialize?
        nil
      else
        find_or_create_task_board
      end
    end

    def initialize_nutrella_configuration
      File.open("#{Dir.home}/.nutrella.yml", "w") { |f| f.write(nutrella_configuration) }
    end

    def nutrella_configuration
      <<-CONFIG.strip_heredoc
        :username : <your username>
        :key : <your developer API Key>
        :secret : <your developer secret>
        :token : <your developer token>
      CONFIG
    end

    def confirm_initialize?
      print "Create initial .nutrella.yml configuration? [y/N]: "
      gets =~ /^y/i
    end

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
