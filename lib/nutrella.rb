require "active_support/core_ext/string"

require "nutrella/cache"
require "nutrella/command"
require "nutrella/configuration"
require "nutrella/developer_keys"
require "nutrella/task_board"
require "nutrella/task_board_name"
require "nutrella/version"

#
# A command line tool for creating a Trello Board based on the current git branch.
#
module Nutrella
  extend DeveloperKeys
end
