require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task(:rubocop) { system "rubocop" }

task :default => [:rubocop, :spec]
