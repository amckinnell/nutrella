module Nutrella
  RSpec.describe Command do
    subject { Command.new("home_dir") }

    it "#cache_filename" do
      expect(subject.cache_filename).to eq("home_dir/.nutrella.cache.yml")
    end

    it "#configuration_filename" do
      expect(subject.configuration_filename).to eq("home_dir/.nutrella.yml")
    end
  end
end
