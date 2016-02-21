require "git"

module Nutrella
  #
  # Knows the name of the task board associated with the current git branch.
  #
  module TaskBoardName
    def self.from_git_branch(dir = ".")
      Git.open(dir).current_branch.humanize.titleize
    rescue
      abort "Sorry. Can't find an associated git branch here."
    end
  end
end
