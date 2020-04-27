RSpec.describe Nutrella::Configuration do
  let(:path) { "path" }
  let(:values) {
    {
      key: "c1",
      secret: "5f",
      token: "3c",
      organization: "org",
      launch_command: "open $url$",
      enable_trello_app: "true",
      enable_logging: "true"
    }
  }

  subject(:configuration) { Nutrella::Configuration.values(path) }

  it "succeeds when the configuration exists and is well formed" do
    configuration_file_contents(values)

    expect(configuration).to include(values)
  end

  it "handles the case when the configuration is missing" do
    configuration_file_missing

    expect(File).to receive(:write).with(path, Nutrella::Configuration::INITIAL_CONFIGURATION)

    expect { configuration }.to output(/you don't have a config file/)
      .to_stderr.and(raise_error(SystemExit))
  end

  it "fails when configuration is malformed (missing secret)" do
    configuration_file_contents(values.except(:secret))

    expect { configuration }.to output(/#{path} key not found: "secret"/)
      .to_stderr.and(raise_error(SystemExit))
  end

  def configuration_file_contents(values)
    allow(File).to receive(:exist?).with(path).and_return(true)
    allow(YAML).to receive(:load_file).with(path).and_return(values.transform_keys(&:to_s))
  end

  def configuration_file_missing
    allow(File).to receive(:exist?).with(path).and_return(false)
  end
end
