# Nutrella

[![Gem Version](http://img.shields.io/gem/v/nutrella.svg?style=flat)](https://rubygems.org/gems/nutrella)
[![Code Climate](https://codeclimate.com/github/amckinnell/nutrella/badges/gpa.svg)](https://codeclimate.com/github/amckinnell/nutrella)
[![Build Status](https://travis-ci.org/amckinnell/nutrella.svg?branch=master)](https://travis-ci.org/amckinnell/nutrella)

A command line tool for associating a Trello board with the current git branch.

## Table of Contents

* [Installation](#installation)
* [Usage](#usage)
* [Troubleshooting](#troubleshooting)
* [Origin of Name](#origin-of-name)
* [Contributing](#contributing)
* [License](#license)


## Installation

**Step 1**: Install gem

    $ gem install nutrella

**Step 2**: Create configuration file

    $ nutrella

**Step 3**: Get key and secret (best to do this from your home directory)

    $ cd ~
    $ irb -r rubygems
    irb> require 'nutrella'
    irb> Nutrella.open_public_key_url

Insert your `key` and `secret` into your `~/.nutrella.yml` file.

**Step 4**: Get token

    irb> Nutrella.open_authorization_url key: '<your_public_key_from_step_3>'

Insert your `token` into your `~/.nutrella.yml` file.

**Step 5**: Update configuration file

If your haven't already done so, insert your `key`, `secret`, and `token` into your `~/.nutrella.yml` file.

The configuration file should look like the following (don't use the keys below, they won't work):

```yaml
    # Trello Developer API Keys
    key: c2fc703429da08b6e7dcb0a878e35564
    secret: 7fd865f372891afa93aabdb6b836254bcda10c8a320def2b3207e2ffb425bc0a
    token: 4c13558cbafdcb4765103a195e05b0476f3b3f7f3efc83f2a810fb769f4ae2d6

    # Optional Configuration
    organization: 542d76ac2fad4697c3e80448
    launch_command: open $url$
    enable_trello_app: false
```

**Step 6**: Adjust configuration file (Optional)

Adjust the `launch_command` configuration to fit your needs.
For example, to open your Trello board in Firefox change your configuration to:

```yaml
    launch_command: open -a firefox $url$
```

Adjust the `enable_trello_app` configuration to open boards in the Trello app.
To open your Trello board in the Trello app change your configuration to:

```yaml
    enable_trello_app: true
```


## Usage

Create or open a Trello board based on the name of the current git branch:

```sh
    $ nutrella
```

Create or open a named Trello board:

```sh
    $ nutrella <git-branch-name>
```

Note: you can invoke `nutrella` from your project directory or from any subdirectory.


## Troubleshooting

1. If an unexpected Trello board is opening try clearing your cache:

    ```sh
    rm ~/.nutrella.cache.yml
    ```

1. If you see `method_missing: undefined method 'this'`

    Try updating `RubyGems`

    ```sh
    gem update --system
    ```

1. If you see `uninitialized constant Gem::Source (NameError)`

    Try updating `bundler`

    ```sh
    gem install bundler
    ```

1. If you see `cannot load such file -- nutrella`

    This error may appear after running `irb -rubygems` and you are unable to `require 'nutrella'`.
    Try running `irb -rubygems` from your home directory:

    ```sh
    cd ~
    ```


## Origin of Name

Nutrella is a [portmanteau](https://en.wikipedia.org/wiki/Portmanteau) that combines these three words:
[Nulogy](http://nulogy.com/), [Trello](http://trello.com/), and [Nutella](http://www.nutella.com/).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/amckinnell/nutrella.
This project is intended to be a safe, welcoming space for collaboration, and contributors are
expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
