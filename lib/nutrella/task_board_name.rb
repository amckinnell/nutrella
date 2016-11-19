require "open3"

module Nutrella
  #
  # Knows the name of the task board associated with the current git branch.
  #
  module TaskBoardName
    def self.from_git_branch
      git_branch_name, status = Open3.capture2('git rev-parse --abbrev-ref HEAD')

      abort "Sorry. Can't find an associated git branch here." unless status.success?

      git_branch_name.chomp.titleize
    end
  end
end
