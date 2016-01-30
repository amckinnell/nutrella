module Nutrella
  #
  # Knows the location and format of the configuration.
  #
  module Configuration
    module_function

    CONFIGURATION_FILENAME = ".nutrella.yml".freeze

    def location
      "#{Dir.home}/#{CONFIGURATION_FILENAME}"
    end

    def write_default
      File.open(location, "w") { |f| f.write(default_nutrella_configuration) }
    end

    private

    def default_nutrella_configuration
      <<-CONFIG.strip_heredoc
        # Trello Username
        :username : <your username>

        # Trello Developer API Keys
        :key : <your developer key>
        :secret : <your developer secret>
        :token : <your developer token>
      CONFIG
    end
  end
end
