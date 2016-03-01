module Nutrella
  RSpec.describe Configuration do
    let(:configuration_path) { "configuration_path" }

    subject { Configuration.new(configuration_path) }

    it "succeeds when the configuration exists and is well formed" do
      configuration_file(key: "c1", secret: "5f", token: "3c", organization: "org")

      expect(subject).to have_attributes(key: "c1", secret: "5f", token: "3c", organization: "org")
    end

    it "handles the case when the configuration is missing" do
      missing_configuration_file

      expect(File).to receive(:write).with(configuration_path, Configuration::INITIAL_CONFIGURATION)

      expect { subject }.to output(/you don't have a config file/).to_stderr.and(raise_error(SystemExit))
    end

    it "fails when configuration is malformed (missing secret)" do
      configuration_file(key: "c1", token: "5f", organization: "org")

      expect { subject }.to output(/#{configuration_path} key not found: "secret"/)
        .to_stderr.and(raise_error(SystemExit))
    end

    def configuration_file(values)
      allow(File).to receive(:exist?).with(configuration_path).and_return(true)
      allow(YAML).to receive(:load_file).with(configuration_path).and_return(values.stringify_keys)
    end

    def missing_configuration_file
      allow(File).to receive(:exist?).with(configuration_path).and_return(false)
    end
  end
end
