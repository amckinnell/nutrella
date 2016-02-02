# Nutrella

[![Gem Version](https://badge.fury.io/rb/nutrella.svg)](https://badge.fury.io/rb/nutrella)
[![Code Climate](https://codeclimate.com/github/amckinnell/nutrella/badges/gpa.svg)](https://codeclimate.com/github/amckinnell/nutrella)
[![security](https://hakiri.io/github/amckinnell/nutrella/master.svg)](https://hakiri.io/github/amckinnell/nutrella/master)

A command line tool for creating a Trello Board to track the engineering tasks for a user story.

_Nutrella_ is a [portmanteau](https://en.wikipedia.org/wiki/Portmanteau) that combines these three words:
[Nulogy](http://nulogy.com/), [Trello](http://trello.com/), and [Nutella](http://www.nutella.com/).


## Installation

    $ gem install nutrella


Create a `.nutrella.yml` file in your home directory:

    $ nutrella --init

Get your developer API keys via the `irb` console (you must be logged into Trello):

    $ irb -rubygems
    irb> require 'trello'
    irb> Trello.open_public_key_url                         # copy your key and secret
    irb> Trello.open_authorization_url key: 'yourpublickey' # copy your token
    irb> exit

Insert your `key`, `secret`, and `token` into your `.nutrella.yml` file.


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
