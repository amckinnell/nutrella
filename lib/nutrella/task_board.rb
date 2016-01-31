require "trello"
require "yaml"

module Nutrella
  #
  # Knows the Trello API for finding and creating task boards.
  #
  class TaskBoard
    LIST_NAMES = %w(Ready Doing Done Issues).freeze

    attr_reader :board_name, :configuration_path

    def initialize(options, configuration_path)
      @board_name = options.board_name
      @configuration_path = configuration_path

      apply_configuration(load_configuration)
    end

    def create
      @cached_task_board ||= begin
        Trello::Board.create(name: board_name).tap do |board|
          LIST_NAMES.each_with_index do |list_name, i|
            Trello::List.create(name: list_name, board_id: board.id, pos: i + 1)
          end
        end
      end
    end

    def exists?
      !find.nil?
    end

    def find
      @cached_task_board ||= member.boards.find { |board| board.name == board_name }
    end

    def name
      board_name
    end

    private

    def load_configuration
      unless File.exist? configuration_path
        fail "#{configuration_path} does not exist. Use the --init option to create"
      end

      YAML.load_file(configuration_path)
    end

    def apply_configuration(configuration)
      @username = configuration.fetch(:username)

      Trello.configure do |config|
        config.consumer_key = configuration.fetch(:key)
        config.consumer_secret = configuration.fetch(:secret)
        config.oauth_token = configuration.fetch(:token)
        config.oauth_token_secret = configuration.fetch(:secret)
      end
    rescue
      raise "#{configuration_path} malformed"
    end

    def member
      Trello::Member.find(@username)
    end
  end
end
