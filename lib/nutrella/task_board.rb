require "trello"

module Nutrella
  #
  # Knows how to use the Trello API to create and lookup task boards.
  #
  class TaskBoard
    def initialize(configuration)
      Trello.configure do |config|
        config.consumer_key = configuration.key
        config.consumer_secret = configuration.secret
        config.oauth_token = configuration.token
        config.oauth_token_secret = configuration.secret
      end
    end

    def create(board_name)
      Trello::Board.create(name: board_name).try(:url)
    end

    def lookup(board_name)
      results = Trello::Action.search(board_name, modelTypes: "boards", board_fields: "name,url")

      results["boards"].find { |board| board.name == board_name }.try(:url)
    end
  end
end
