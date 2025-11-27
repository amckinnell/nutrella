# frozen_string_literal: true

require "open3"

module Nutrella
  #
  # Knows the name of the task board associated with the current git branch.
  #
  # Note: will also accept the name of a branch as an argument.
  #
  # Trailing all-caps suffixes (e.g., -SPIKE, -KEEP, -INVESTIGATE) are automatically
  # removed from branch names when generating the task board name.
  #
  class TaskBoardName
    def self.board_name_from_git_branch(args)
      git_branch_name = args[0]
      return git_branch_name.sub(/-[A-Z]+$/, "") if git_branch_name.present?

      git_branch_name, status = Open3.capture2("git rev-parse --abbrev-ref HEAD")
      abort "Sorry. Can't figure out a name for the board." unless status.success?

      git_branch_name.chomp.sub(/-[A-Z]+$/, "")
    end
  end
end
