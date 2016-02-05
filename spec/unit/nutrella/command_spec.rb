module Nutrella
  RSpec.describe Command do
    it "fails when options don't parse" do
      expect { Command.new("--invalid-option").task_board }.to output(/Error: invalid option/).to_stderr.and raise_error(SystemExit)
    end

    it "displays usage" do
      expect { Command.new("-h").task_board }.to output(/Usage:/).to_stdout
    end

    it "displays version" do
      expect { Command.new("-v").task_board }.to output(/#{Nutrella::VERSION}/).to_stdout
    end
  end
end
