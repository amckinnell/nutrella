# Nutrella

[![Gem Version](https://badge.fury.io/rb/nutrella.svg)](https://badge.fury.io/rb/nutrella)
[![Code Climate](https://codeclimate.com/github/amckinnell/nutrella/badges/gpa.svg)](https://codeclimate.com/github/amckinnell/nutrella)
[![security](https://hakiri.io/github/amckinnell/nutrella/master.svg)](https://hakiri.io/github/amckinnell/nutrella/master)

A command line tool for creating a Trello Board to track the engineering tasks for a user story.

Nutrella is a [portmanteau](https://en.wikipedia.org/wiki/Portmanteau) that combines these three words:
[Nulogy](http://nulogy.com/), [Trello](http://trello.com/), and [Nutella](http://www.nutella.com/).


## Installation

    $ gem install nutrella


## Usage

    Usage: nutrella [options]
        -g, --current-git-branch         Open the board matching the current git branch
        -t, --trello-board BOARD         Open the board with name BOARD
            --init                       Initialize the nutrella.yml configuration
        -v, --version                    Display the version
        -h, --help                       Display this screen

    Note: invoking nutrella with no options is equivalent to nutrella -g


## Configuration

Create a `.nutrella.yml` file in your home directory using:

    $ nutrella --init

The configuration file has the following format:

    # Trello Username
    :username : <your username>

    # Trello Developer API Keys
    :key : <your developer key>
    :secret : <your developer secret>
    :token : <your developer token>

Get your developer API keys from Trello via the irb console (you must first be logged into Trello):

    $ gem install nutrella
    $ irb -rubygems
    irb> require 'trello'
    irb> Trello.open_public_key_url                         # copy your public key
    irb> Trello.open_authorization_url key: 'yourpublickey' # copy your member token

Insert the developer API keys into your `.nutrella.yml` configuration.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/amckinnell/nutrella.
This project is intended to be a safe, welcoming space for collaboration, and contributors are
expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
