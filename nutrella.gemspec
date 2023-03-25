lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nutrella/version"

Gem::Specification.new do |spec|
  spec.name          = "nutrella"
  spec.version       = Nutrella::VERSION
  spec.authors       = ["Alistair McKinnell"]
  spec.email         = ["alistair.mckinnell@gmail.com"]

  spec.summary       = "A command line tool for creating a Trello Board based on the current git branch."
  spec.homepage      = "https://github.com/amckinnell/nutrella"
  spec.license       = "MIT"

  spec.metadata = {
    "homepage_uri" => "https://github.com/amckinnell/nutrella",
    "changelog_uri" => "https://github.com/amckinnell/nutrella/blob/master/CHANGELOG.md",
    "source_code_uri" => "https://github.com/amckinnell/nutrella",
    "bug_tracker_uri" => "https://github.com/amckinnell/nutrella/issues",
    "rubygems_mfa_required" => "true"
  }

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.0"

  spec.add_runtime_dependency "ruby-trello", "~> 4.0"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.12"
  spec.add_development_dependency "rubocop", "~> 1.48"
  spec.add_development_dependency "rubocop-rake", "~> 0.6"
  spec.add_development_dependency "rubocop-rspec", "~> 2.19"
  spec.add_development_dependency "simplecov", "~> 0.22"
end
