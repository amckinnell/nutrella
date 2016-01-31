module Nutrella
  #
  # Knows the location and format of the configuration.
  #
  module Configuration
    module_function

    CONFIGURATION_FILENAME = ".nutrella.yml".freeze

    DEFAULT_CONFIGURATION = <<-DEFAULT_CONFIG.strip_heredoc.freeze
        # Trello Username
        :username : <your username>

        # Trello Developer API Keys
        :key : <your developer key>
        :secret : <your developer secret>
        :token : <your developer token>
    DEFAULT_CONFIG

    def location
      "#{Dir.home}/#{CONFIGURATION_FILENAME}"
    end

    def write_default
      File.open(location, "w") { |f| f.write(DEFAULT_CONFIGURATION) }
    end
  end
end