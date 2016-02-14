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

    attr_reader :key, :path, :secret, :token

    def initialize(path)
      @path = path

      load_configuration unless missing_configuration?
    end

    private

    def load_configuration
      configuration = YAML.load_file(path)

      @key = configuration.fetch(:key)
      @secret = configuration.fetch(:secret)
      @token = configuration.fetch(:token)
    rescue => e
      raise "#{path} malformed: #{e.message}"
    end

    def missing_configuration?
      return false if File.exist?(path)

      write_initial_configuration
      abort missing_configuration_message
    end

    def write_initial_configuration
      File.write(path, INITIAL_CONFIGURATION)
    end

    def missing_configuration_message
      <<-TEXT.strip_heredoc
        I see that you don't have a config file '#{path}''.
        So, I created one for you.

        You still need to enter your Trello API keys in the config file.

        See https://github.com/amckinnell/nutrella for instructions.
      TEXT
    end
  end
end
