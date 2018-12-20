# frozen_string_literal: true

require "trello"

module Nutrella
  #
  # Knows how to use the Trello API to create and lookup task boards.
  #
  class TaskBoard
    def initialize(configuration)
      Trello.configure do |trello_client|
        trello_client.consumer_key = configuration.fetch(:key)
        trello_client.consumer_secret = configuration.fetch(:secret)
        trello_client.oauth_token = configuration.fetch(:token)
        trello_client.oauth_token_secret = configuration.fetch(:secret)
      end

      @organization = configuration.fetch(:organization)
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
      Trello::Board.create(name: board_name, organization_id: @organization)
    end

    def make_team_visible(board)
      Trello.client.put("/boards/#{board.id}", "prefs/permissionLevel=org")
    end
  end
end
