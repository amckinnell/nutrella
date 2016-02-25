require "trello"

module Nutrella
  #
  # Knows how to use the Trello API to create and lookup task boards.
  #
  class TaskBoard
    NULOGY_ORGANIZATION_ID = "542d76ac2fad4697c3e80448"

    def initialize(configuration)
      Trello.configure do |config|
        config.consumer_key = configuration.key
        config.consumer_secret = configuration.secret
        config.oauth_token = configuration.token
        config.oauth_token_secret = configuration.secret
      end
    end

    def lookup_or_create(board_name)
      lookup(board_name) || create(board_name)
    end

    private

    def lookup(board_name)
      matching_boards(board_name).find { |board| board.name == board_name }
    end

    def matching_boards(board_name)
      Trello::Action.search(board_name, modelTypes: "boards", board_fields: "all").fetch("boards", [])
    end

    def create(board_name)
      create_board(board_name).tap { |board| make_team_visible(board) }
    end

    def create_board(board_name)
      Trello::Board.create(name: board_name, organization_id: NULOGY_ORGANIZATION_ID)
    end

    def make_team_visible(board)
      Trello.client.put("/boards/#{board.id}", "prefs/permissionLevel=org") if board
    end
  end
end
