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

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.3"

  spec.add_runtime_dependency "ruby-trello", "~> 2.1"

  spec.add_development_dependency "rake", "~> 12.1"
  spec.add_development_dependency "rspec", "~> 3.7"
  spec.add_development_dependency "rubocop", "~> 0.61"
  spec.add_development_dependency "simplecov", "~> 0.16"
end
