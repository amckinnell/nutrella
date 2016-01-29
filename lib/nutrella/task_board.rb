require "trello"
require "yaml"

module Nutrella
  class TaskBoard
    def initialize(options)
      @board_name = options.board_name
      configure_trello
    end

    def create
      @cached_task_board ||= begin
        Trello::Board.create(name: @board_name, organization_id: @organization_id).tap do |board|
          %w(Ready Doing Done Issues).each_with_index do |list_name, i|
            Trello::List.create(name: list_name, board_id: board.id, pos: i + 1)
          end
        end
      end
    end

    def exists?
      !find.nil?
    end

    def find
      @cached_task_board ||= member.boards.find { |board| board.name == @board_name }
    end

    def name
      @board_name
    end

    private

    def configure_trello
      trello_keys = YAML.load_file("#{Dir.home}/.trello_config.yml")

      @member_id = trello_keys.fetch(:member_id)
      @organization_id = trello_keys.fetch(:organization_id)

      Trello.configure do |config|
        config.consumer_key = trello_keys.fetch(:key)
        config.consumer_secret = trello_keys.fetch(:secret)
        config.oauth_token = trello_keys.fetch(:token)
        config.oauth_token_secret = trello_keys.fetch(:secret)
      end
    end

    def member
      Trello::Member.find(@member_id)
    end
  end
end
