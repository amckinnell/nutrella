require "git"

module Nutrella
  #
  # Knows the name of the task board associated with the current git branch.
  #
  module TaskBoardName
    def self.from_git_branch(working_dir = ".")
      Git.open(working_dir).current_branch.titleize
    rescue
      abort "Sorry. Can't find an associated git branch here."
    end
  end
end
