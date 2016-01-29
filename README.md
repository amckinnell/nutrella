# Nutrella

[![Gem Version](https://badge.fury.io/rb/nutrella.svg)](https://badge.fury.io/rb/nutrella)
[![Code Climate](https://codeclimate.com/github/amckinnell/nutrella/badges/gpa.svg)](https://codeclimate.com/github/amckinnell/nutrella)

A command line tool for creating a Trello Board to track the engineering tasks for a user story.

Nutrella is a [portmanteau](https://en.wikipedia.org/wiki/Portmanteau) that combines these three words:
[Nulogy](http://nulogy.com/), [Trello](http://trello.com/), and [Nutella](http://www.nutella.com/).


## Installation

    $ gem install nutrella


## Usage

    Usage: nutrella [options]
        -g, --current-git-branch         Open the Trello Board matching the current git branch
        -t, --trello-board BOARD         Open the Trello Board with name BOARD
        -h, --help                       Display this screen

    Note: invoking nutrella with no options is equivalent to nutrella -g


## Trello Configuration

Create a `.trello_config.YML` file in your home directory with the following format:

    :member_id : <member_id>
    :organization_id : <organization_id>
    :key : <key>
    :secret : <secret>
    :token : <token>


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/amckinnell/nutrella.
This project is intended to be a safe, welcoming space for collaboration, and contributors are
expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

