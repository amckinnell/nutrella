module Nutrella
  RSpec.describe Configuration do
    let(:configuration_directory) { "home_dir" }
    let(:subject) { Configuration.new(configuration_directory) }

    it "succeeds when configuration exists and is well formed" do
      configuration_file(key: "c1", secret: "5f", token: "3c")

      expect(subject).to have_attributes(key: "c1", secret: "5f", token: "3c")
    end

    it "handles the case when the configuration is missing" do
      missing_configuration_file

      expect(File).to receive(:write).with(path, Configuration::INITIAL_CONFIGURATION)

      expect { subject }.to output(/you don't have a config file/).to_stderr.and(raise_error(SystemExit))
    end

    it "fails when configuration is malformed (missing secret)" do
      configuration_file(key: "c1", token: "5f")

      expect { subject }.to output(/#{path} malformed/).to_stderr.and(raise_error(SystemExit))
    end

    def configuration_file(values)
      allow(File).to receive(:exist?).with(path).and_return(true)
      allow(YAML).to receive(:load_file).with(path).and_return(values.stringify_keys)
    end

    def missing_configuration_file
      allow(File).to receive(:exist?).with(path).and_return(false)
    end

    def path
      File.join(configuration_directory, Configuration::CONFIGURATION_FILENAME)
    end
  end
end
