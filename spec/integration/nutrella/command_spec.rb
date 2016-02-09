module Nutrella
  vcr_options = { cassette_name: "nutrella", record: :new_episodes }

  RSpec.describe Command, vcr: vcr_options do
    let(:path) { "home_dir/config.yml" }
    let(:subject) { Command.new(path) }

    xit "creates an initial configuration when missing" do
      expect(File).to receive(:write).with(path, Configuration::INITIAL_CONFIGURATION)

      expect { subject.run }.to(
        output(/you don't have a config file/).to_stderr.and(raise_error(SystemExit))
      )
    end

    it "looks up an existing board"

    it "creates a new board"
  end
end
