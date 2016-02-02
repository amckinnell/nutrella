module Nutrella
  RSpec.describe Command do
    it "fails when options don't parse" do
      options = instance_double(Options)
      allow(options).to receive(:parse).and_raise("message")

      expect { Command.new(options).task_board }.to output(/Error: message/).to_stdout
        .and raise_error(SystemExit)
    end

    it "displays usage" do
      options = Options.new(["-h"])
      options.parse

      expect { Command.new(options).task_board }.to output(/Usage:/).to_stdout
    end

    it "displays version" do
      options = Options.new(["-v"])
      options.parse

      expect { Command.new(options).task_board }.to output(/#{Nutrella::VERSION}/).to_stdout
    end
  end
end
