require "trello"

module Nutrella
  #
  # Knows the Trello API for creating and finding task board URLs.
  #
  class TaskBoard
    def initialize(configuration)
      configuration.apply
    end

    def create(board_name)
      Trello::Board.create(name: board_name).try(:url)
    end

    def find(board_name)
      results = Trello::Action.search(board_name, modelTypes: "boards", board_fields: "name,url")

      results["boards"].find { |board| board.name == board_name }.try(:url)
    end
  end
end
