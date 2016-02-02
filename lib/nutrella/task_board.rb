require "trello"
require "yaml"

module Nutrella
  #
  # Knows the Trello API for finding and creating task boards.
  #
  class TaskBoard
    attr_reader :name, :configuration_path

    def initialize(options, configuration_path)
      @name = options.board_name
      @configuration_path = configuration_path

      apply_configuration(load_configuration)
    end

    def create
      Trello::Board.create(name: name)
    end

    def find
      results = Trello::Action.search(name, modelTypes: "boards", board_fields: "name,url")

      results["boards"].find { |board| board.name == name }
    end

    private

    def load_configuration
      unless File.exist? configuration_path
        fail MissingConfiguration, "#{configuration_path} does not exist. Use the --init option to create"
      end

      YAML.load_file(configuration_path)
    end

    def apply_configuration(configuration)
      Trello.configure do |config|
        config.consumer_key = configuration.fetch("key")
        config.consumer_secret = configuration.fetch("secret")
        config.oauth_token = configuration.fetch("token")
        config.oauth_token_secret = configuration.fetch("secret")
      end
    rescue
      raise MalformedConfiguration, "#{configuration_path} malformed"
    end
  end

  class MalformedConfiguration < StandardError; end
  class MissingConfiguration < StandardError; end
end
