# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- Address rubocop violations
- Update development dependencies

## [1.7.1] - 2023-05-05

#### Bug Fix

- Fix board creation (which was broken due to changes in the Trello API)

## [1.7.0] - 2023-03-25

- Update ruby-trello
- Update development dependencies

#### Breaking Changes

- Drop support for all Ruby 2.x versions

## [1.6.0] - 2021-07-30

#### New Features

- Allow opening a previously created Trello board based on a JIRA ticket
- Added a configuration option to specify exactly how to search in the cache first

## [1.5.4] - 2021-07-29

#### New Features

- Added a configuration option to adjust the cache capacity

## [1.5.3] - 2021-02-18

- Update ruby-trello
- Update development dependencies

#### Breaking Changes

- Drop support for Ruby 2.5

## [1.5.2] - 2020-04-27

#### New Features

- Added a configuration option to enable logging for easier troubleshooting

## [1.5.1] - 2020-04-27

#### Bug Fix

- Honour the specified named Trello board argument over the Trello board derived from the current git branch

## [1.5.0] - 2020-04-26

#### New Features

- Added a configuration option to support opening boards in the desktop Trello app

## [1.4.0] - 2020-03-30

#### Breaking Changes

- Drop support for Ruby 2.4

## [1.3.1] - 2019-05-20

#### New Features

- Added a configuration option to adjust the command that launches your Trello boards

## [1.3.0] - 2019-05-20

- Yanked

## [1.2.2] - 2019-04-27

- Added a changelog
