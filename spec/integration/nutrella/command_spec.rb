module Nutrella
  vcr_options = { cassette_name: "nutrella", record: :new_episodes }

  RSpec.describe Command, vcr: vcr_options do
    it "displays help" do
      expect { subject.run(["-h"]) }.to output(/Usage:/).to_stdout
    end

    it "finds an existing board" do
      disable_cache

      expect(subject).to receive(:system).with(match(%r{open https://trello.com/b/.*/nutrella}))

      subject.run(["-t", "Nutrella"])
    end

    it "fails when options don't parse" do
      expect { subject.run(["--invalid-option"]) }.to(
        output(/Error: invalid option/).to_stderr.and(raise_error(SystemExit))
      )
    end

    def disable_cache
      allow_any_instance_of(Cache).to receive(:get).and_yield
      allow_any_instance_of(Cache).to receive(:put).and_yield
    end
  end
end
