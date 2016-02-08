require "yaml"

module Nutrella
  #
  # Knows the location and format of the configuration.
  #
  class Configuration
    INITIAL_CONFIGURATION = <<-YAML.strip_heredoc
      # Trello Developer API Keys
      key: <your developer key>
      secret: <your developer secret>
      token: <your developer token>
    YAML

    attr_reader :path

    def initialize(path)
      @path = path
    end

    def apply
      apply_configuration(load_configuration)
    end

    private

    def apply_configuration(configuration)
      Trello.configure do |config|
        config.consumer_key = configuration.fetch("key")
        config.consumer_secret = configuration.fetch("secret")
        config.oauth_token = configuration.fetch("token")
        config.oauth_token_secret = configuration.fetch("secret")
      end
    rescue
      raise "#{path} malformed"
    end

    def load_configuration
      unless File.exist?(path)
        write_initial_configuration
        abort configuration_file_not_found_message
      end

      YAML.load_file(path)
    end

    def write_initial_configuration
      raise "#{path} exists" if File.exist?(path)

      File.write(path, INITIAL_CONFIGURATION)
    end

    def configuration_file_not_found_message
      <<-TEXT.strip_heredoc
        I see that you don't have a config file #{path}.
        So, I created one for you.

        You still need to enter your Trello API keys in the config file.

        See https://github.com/amckinnell/nutrella for instructions.
      TEXT
    end
  end
end
