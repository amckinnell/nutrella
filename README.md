# Nutrella

[![Gem Version](https://badge.fury.io/rb/nutrella.svg)](https://badge.fury.io/rb/nutrella)
[![Code Climate](https://codeclimate.com/github/amckinnell/nutrella/badges/gpa.svg)](https://codeclimate.com/github/amckinnell/nutrella)
[![GitHub license](https://img.shields.io/github/license/mashape/apistatus.svg)]()

A command line tool for associating a Trello board with the current git branch.

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
* [Origin of Name](#origin-of-name)
* [Contributing](#contributing)
* [License](#license)


## Installation

**Step 1**: Install gem

    $ gem install nutrella

**Step 2**: Create configuration file

    $ nutrella

**Step 3**: Get key and secret

    $ irb -rubygems
    irb> require 'nutrella'
    irb> Nutrella.open_public_key_url

Insert your `key` and `secret` into your `~/.nutrella.yml` file.

**Step 4**: Get token

    irb> Nutrella.open_authorization_url key: '<your_public_key_from_step_3>'

Insert your `token` into your `~/.nutrella.yml` file.

**Step 5**: Update configuration file

If your haven't already done so, insert your `key`, `secret`, and `token` into your `~/.nutrella.yml` file.

The configuration file should look like the following (don't use the keys below, they won't work) :

    # Trello Developer API Keys
    key: c2fc703429da08b6e7dcb0a878e35564
    secret: 7fd865f372891afa93aabdb6b836254bcda10c8a320def2b3207e2ffb425bc0a
    token: 4c13558cbafdcb4765103a195e05b0476f3b3f7f3efc83f2a810fb769f4ae2d6

    # Optional Configuration
    organization: 542d76ac2fad4697c3e80448

### Troubleshooting

If you run into the following error:

```
method_missing: undefined method `this' for #<Gem::Specification:0x3fd505420fbc nutrella-0.4.0> (NoMethodError)
```

it means that you need to update your system's RubyGems version. Apparently there is some sort of version incompatibility for some versioning permutations of Nutrella, Ruby, and RubyGems. Run this to execute the fix:

```
gem update --system
```

## Usage

Create or open a Trello board based on the name of the current git branch:

    $ nutrella


## Origin of Name

Nutrella is a [portmanteau](https://en.wikipedia.org/wiki/Portmanteau) that combines these three words:
[Nulogy](http://nulogy.com/), [Trello](http://trello.com/), and [Nutella](http://www.nutella.com/).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/amckinnell/nutrella.
This project is intended to be a safe, welcoming space for collaboration, and contributors are
expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
