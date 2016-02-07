require "git"

module Nutrella
  #
  # Knows the name of the task board associated with the current git branch.
  #
  module TaskBoardName
    def self.current_git_branch
      Git.open(".").current_branch.humanize.titleize
    end
  end
end
