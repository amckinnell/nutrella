require "trello"
require "yaml"

module Nutrella
  class Board
    def initialize(options)
      @board_name = options.board_name
      @member_id = "amckinnell"
    end

    def open_board
      configure
      system "open #{find_board.url}"
    end

    def configure
      trello_keys = YAML.load_file("trello_keys.yml")

      Trello.configure do |config|
        config.consumer_key = trello_keys.fetch(:key)
        config.consumer_secret = trello_keys.fetch(:secret)
        config.oauth_token = trello_keys.fetch(:token)
        config.oauth_token_secret = trello_keys.fetch(:secret)
      end
    end

    def find_board
      member.boards.find { |board| board.name == @board_name }
    end

    def member
      Trello::Member.find(@member_id)
    end
  end
end
