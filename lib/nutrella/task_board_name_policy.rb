require "git"

module Nutrella
  #
  # Knows the name of the task board associated with the current git branch.
  #
  module TaskBoardNamePolicy
    def self.from_git_branch
      Git.open(".").current_branch.humanize.titleize
    end
  end
end
