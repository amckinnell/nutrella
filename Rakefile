require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"

RuboCop::RakeTask.new
RSpec::Core::RakeTask.new(:spec)

task(:backup_configuration) { system "cp ~/.nutrella.yml ~/.nutrella.yml.bak" }
task(:restore_configuration) { system "cp ~/.nutrella.yml.bak ~/.nutrella.yml" }

task(:remove_cache) { system "rm ~/.nutrella.cache.yml" }
task(:remove_configuration) { system "rm ~/.nutrella.yml" }
task(:local_install) { system "gem uninstall nutrella -ax && rubocop -a && rake install" }

task :default => [:rubocop, :spec]
