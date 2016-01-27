require "git"

module Nutrella
  class Command
    attr_reader :args

    def initialize(*args)
      @args = args
    end

    def run
      puts "Arguments: #{ARGV}"

      g = Git.open(".")
      puts "Current branch: #{g.current_branch}"
    end
  end
end
