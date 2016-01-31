module Nutrella
  RSpec.describe Configuration do
    it ".path" do
      allow(Dir).to receive(:home).and_return("home_dir")

      expect(Configuration.path).to eq("home_dir/.nutrella.yml")
    end
  end
end
