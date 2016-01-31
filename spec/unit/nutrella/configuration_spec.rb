module Nutrella
  RSpec.describe Configuration do
    it ".location" do
      allow(Dir).to receive(:home).and_return("home_dir")

      expect(Configuration.location).to eq("home_dir/.nutrella.yml")
    end
  end
end
