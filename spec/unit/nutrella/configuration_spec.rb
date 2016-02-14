module Nutrella
  RSpec.describe Configuration do
    let(:path) { "home_dir/config.yml" }
    let(:subject) { Configuration.new(path) }

    describe "#initialize" do
      it "succeeds when configuration exists and YAML well formed" do
        configuration_exists

        allow(YAML).to receive(:load_file).with(path).and_return(
          key: "c1",
          secret: "5f",
          token: "3c"
        )

        expect(subject).to have_attributes(
          key: "c1",
          secret: "5f",
          token: "3c"
        )
      end

      it "handles the case when the configuration is missing" do
        configuration_missing

        expect(File).to receive(:write).with(path, Configuration::INITIAL_CONFIGURATION)

        expect { subject }.to(
          output(/you don't have a config file/).to_stderr.and(raise_error(SystemExit))
        )
      end

      it "fails when configuration is malformed" do
        configuration_exists

        allow(YAML).to receive(:load_file).with(path).and_return(
          key: "c1",
          token: "5f"
        )

        expect { subject }.to raise_error(/#{path} malformed/)
      end
    end

    def configuration_exists
      allow(File).to receive(:exist?).with(path).and_return(true)
    end

    def configuration_missing
      allow(File).to receive(:exist?).with(path).and_return(false)
    end
  end
end
