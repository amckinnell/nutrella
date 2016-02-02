# Nutrella

[![Gem Version](https://badge.fury.io/rb/nutrella.svg)](https://badge.fury.io/rb/nutrella)
[![Code Climate](https://codeclimate.com/github/amckinnell/nutrella/badges/gpa.svg)](https://codeclimate.com/github/amckinnell/nutrella)
[![security](https://hakiri.io/github/amckinnell/nutrella/master.svg)](https://hakiri.io/github/amckinnell/nutrella/master)

A command line tool for creating a Trello Board to track the engineering tasks for a user story.

Nutrella makes it easy to connect a git branch to a Trello board. The expected workflow is as follows:

1. Prepare to work on a feature
2. Create a feature branch
3. Use Nutrella to open a task board to manage the feature's engineering tasks


_Nutrella_ is a [portmanteau](https://en.wikipedia.org/wiki/Portmanteau) that combines these three words:
[Nulogy](http://nulogy.com/), [Trello](http://trello.com/), and [Nutella](http://www.nutella.com/).


## Installation

Follow these steps:

1. Install the latest version of the Nutrella gem
2. Use Nutrella to create a configuration file
3. Grab your developer keys from Trello and add them to the configuration file
4. Use Nutrella to smooth out your workflow

**Step 1**: Install the latest version of the Nutrella gem

    $ gem install nutrella

**Step 2**: Use Nutrella to create a configuration file in your home directory

    $ nutrella --init

**Step 3**: Grab your developer keys from Trello and add them to the configuration file

    $ irb -rubygems
    irb> require 'trello'
    irb> Trello.open_public_key_url                         # copy your key and secret
    irb> Trello.open_authorization_url key: 'yourpublickey' # copy your token
    irb> exit

Insert your `key`, `secret`, and `token` into your `~/.nutrella.yml` file.

**Step 4**: Use Nutrella to smooth out your workflow

    $ nutrella


## Usage

The name of the current git branch is used to create or open a task board:

    $ nutrella

To open a named task board (such as the Team Assassins task board):

    $ nutrella -t Assassins

Use the `-h` option to see all the command line options.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/amckinnell/nutrella.
This project is intended to be a safe, welcoming space for collaboration, and contributors are
expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
