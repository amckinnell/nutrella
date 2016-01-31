module Nutrella
  RSpec.describe Command do
    it "#task_board" do
      options = instance_double(Options)
      allow(options).to receive(:parse).and_raise("message")

      expect { Command.new(options).task_board }.to output(/Error: message/).to_stdout
        .and raise_error(SystemExit)
    end
  end
end
