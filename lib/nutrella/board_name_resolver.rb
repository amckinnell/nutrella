module Nutrella
  #
  # Knows how to take the supplied board name and resolve it to a Trello board url.
  #
  class BoardNameResolver
    def initialize(url_cache, search_specification)
      @url_cache = url_cache
      @search_specification = search_specification
    end

    def resolve(board_name, &block)
      matching_url(board_name) || cached_url(board_name, &block)
    end

    private

    def matching_url(board_name)
      return nil unless @search_specification.match?(board_name)

      search_reg_exp = Regexp.new(board_name, Regexp::IGNORECASE)

      @url_cache.search(search_reg_exp)
    end

    def cached_url(board_name, &block)
      @url_cache.fetch(board_name, &block)
    end
  end
end
