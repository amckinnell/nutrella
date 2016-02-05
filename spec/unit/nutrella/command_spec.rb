module Nutrella
  RSpec.describe Command do
    it "fails when options don't parse" do
      expect { Command.new(["--invalid-option"]).task_board }.to(
        output(/Error: invalid option/).to_stderr.and(raise_error(SystemExit))
      )
    end
  end
end
