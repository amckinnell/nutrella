require "yaml"

module Nutrella
  #
  # Knows the location and format of the configuration.
  #
  class Configuration
    CONFIGURATION_FILENAME = ".nutrella.yml".freeze

    DEFAULT_CONFIGURATION = <<-DEFAULT_CONFIG.strip_heredoc.freeze
        # Trello Developer API Keys
        key: <your developer key>
        secret: <your developer secret>
        token: <your developer token>
      DEFAULT_CONFIG

    def apply
      apply_configuration(load_configuration)
    end

    def write_default
      fail ExistingConfiguration, "#{path} exists" if File.exist? path

      File.open(path, "w") { |f| f.write(DEFAULT_CONFIGURATION) }
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
      raise MalformedConfiguration, "#{path} malformed"
    end

    def load_configuration
      unless File.exist? path
        fail MissingConfiguration, "#{path} does not exist. Use the --init option to create"
      end

      YAML.load_file(path)
    end

    def path
      "#{Dir.home}/#{CONFIGURATION_FILENAME}"
    end
  end

  class ExistingConfiguration < StandardError; end
  class MalformedConfiguration < StandardError; end
  class MissingConfiguration < StandardError; end
end
