module Nutrella
  RSpec.describe Configuration do
    let(:home) { "home_dir" }
    let(:path) { "home_dir/#{Configuration::CONFIGURATION_FILENAME}" }

    describe "#write_default" do
      it "succeeds when configuration missing" do
        configuration_missing

        expect(File).to receive(:open).with(path, "w")

        subject.write_default
      end

      it "fails when configuration exists" do
        configuration_exists

        expect { subject.write_default }.to raise_error(
          ExistingConfiguration, /#{path} exists/)
      end
    end

    describe "#apply_configuration" do
      it "succeeds when configuration exists and YAML well formed" do
        configuration_exists

        allow(YAML).to receive(:load_file).with(path).and_return(
          "key" => "c1",
          "secret" => "5f",
          "token" => "3c"
        )

        subject.apply

        expect(Trello.configuration).to have_attributes(
          consumer_key: "c1",
          consumer_secret: "5f",
          oauth_token: "3c",
          oauth_token_secret: "5f"
        )
      end

      it "fails when configuration is missing" do
        configuration_missing

        expect { subject.apply }.to raise_error(
          MissingConfiguration, /#{path} does not exist/)
      end

      it "fails when configuration is malformed" do
        configuration_exists

        allow(YAML).to receive(:load_file).with(path).and_return(
          "key" => "c1",
          "token" => "5f"
        )

        expect { subject.apply }.to raise_error(
          MalformedConfiguration, /#{path} malformed/)
      end
    end

    def configuration_exists
      allow(Dir).to receive(:home).and_return(home)
      allow(File).to receive(:exist?).with(path).and_return(true)
    end

    def configuration_missing
      allow(Dir).to receive(:home).and_return(home)
      allow(File).to receive(:exist?).with(path).and_return(false)
    end
  end
end
