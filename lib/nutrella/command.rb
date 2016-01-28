require "trello"
require "yaml"

module Nutrella
  class Command
    def initialize(args)
      @options = Options.new(args)
      @member_id = "amckinnell"
    end

    def run
      open_board if @options.parse
    rescue OptionParser::InvalidOption => e
      puts e
    end

    private

    def open_board
      configure_trello
      system "open #{find_board.url}"
    end

    def configure_trello
      trello_keys = YAML.load_file("trello_keys.yml")

      Trello.configure do |config|
        config.consumer_key = trello_keys.fetch(:key)
        config.consumer_secret = trello_keys.fetch(:secret)
        config.oauth_token = trello_keys.fetch(:token)
        config.oauth_token_secret = trello_keys.fetch(:secret)
      end
    end

    def find_board
      member.boards.find { |board| board.name == @options.board_name }
    end

    def member
      Trello::Member.find(@member_id)
    end
  end
end
