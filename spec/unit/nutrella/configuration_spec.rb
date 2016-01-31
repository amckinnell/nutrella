module Nutrella
  RSpec.describe Configuration do
    it ".path" do
      allow(Dir).to receive(:home).and_return("home_dir")

      expect(Configuration.path).to eq("home_dir/.nutrella.yml")
    end

    it ".write_default when configuration exists" do
      allow(Dir).to receive(:home).and_return("home_dir")
      allow(File).to receive(:exist?).and_return(true)

      expect { Configuration.write_default }.to raise_error(RuntimeError, %r{home_dir/.nutrella.yml exists})
    end
  end
end
