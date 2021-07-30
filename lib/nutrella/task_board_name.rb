# frozen_string_literal: true

require "open3"

module Nutrella
  #
  # Knows the name of the task board associated with the current git branch.
  #
  # Note: will also accept the name of a branch as an argument.
  #
  class TaskBoardName
    def self.board_name_from_git_branch(args)
      git_branch_name = args[0]
      return git_branch_name if git_branch_name.present?

      git_branch_name, status = Open3.capture2("git rev-parse --abbrev-ref HEAD")
      return git_branch_name.chomp if status.success?

      abort "Sorry. Can't figure out a name for the board."
    end
  end
end
