# frozen_string_literal: true

require "yaml"

module Nutrella
  #
  # Knows the location and format of the configuration.
  #
  class Configuration
    NULOGY_ORGANIZATION_ID = "542d76ac2fad4697c3e80448"

    INITIAL_CONFIGURATION = <<~YAML
      # Trello Developer API Keys
      key: <your developer key>
      secret: <your developer secret>
      token: <your developer token>

      # Optional Configuration
      organization: #{NULOGY_ORGANIZATION_ID}
      launch_command: open $url$
      enable_trello_app: false
      enable_logging: false
      cache_capacity: 5
      cache_first: '^PM-\d+'
    YAML

    attr_reader :path, :values

    def self.values(path)
      new(path).values
    end

    def initialize(path)
      @path = path

      load_configuration unless configuration_missing?
    end

    private

    def load_configuration # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      @values = {
        key: configuration.fetch("key"),
        secret: configuration.fetch("secret"),
        token: configuration.fetch("token"),
        organization: configuration.fetch("organization", NULOGY_ORGANIZATION_ID),
        launch_command: configuration.fetch("launch_command", "open $url$"),
        enable_trello_app: configuration.fetch("enable_trello_app", "false"),
        enable_logging: configuration.fetch("enable_logging", "false"),
        cache_capacity: configuration.fetch("cache_capacity", 5),
        cache_first: to_reg_exp("cache_first")
      }
    rescue => e
      abort "#{path} #{e}"
    end

    def configuration
      @_configuration ||= YAML.load_file(path)
    end

    def configuration_missing?
      return false if File.exist?(path)

      write_initial_configuration
      abort configuration_missing_message
    end

    def write_initial_configuration
      File.write(path, INITIAL_CONFIGURATION)
    end

    def configuration_missing_message
      <<~TEXT
        I see that you don't have a config file '#{path}'.
        So, I created one for you.

        You still need to enter your Trello API keys into the config file.

        See https://github.com/amckinnell/nutrella for instructions.
      TEXT
    end

    def to_reg_exp(key)
      Regexp.new(configuration.fetch(key, '^PM-\d+'), Regexp::IGNORECASE)
    end
  end
end
