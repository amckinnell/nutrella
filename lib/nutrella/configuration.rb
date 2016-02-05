require "yaml"

module Nutrella
  #
  # Knows the location and format of the configuration.
  #
  class Configuration
    CONFIGURATION_FILENAME = ".nutrella.yml"

    DEFAULT_CONFIGURATION = <<-DEFAULT_CONFIG.strip_heredoc
      # Trello Developer API Keys
      key: <your developer key>
      secret: <your developer secret>
      token: <your developer token>
    DEFAULT_CONFIG

    def apply
      apply_configuration(load_configuration)
    end

    def write_default
      raise "#{path} exists" if File.exist?(path)

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
      raise "#{path} malformed"
    end

    def load_configuration
      raise "#{path} does not exist. Use the --init option to create" unless File.exist?(path)

      YAML.load_file(path)
    end

    def path
      "#{Dir.home}/#{CONFIGURATION_FILENAME}"
    end
  end
end
