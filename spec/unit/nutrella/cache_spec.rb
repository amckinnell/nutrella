module Nutrella
  RSpec.describe Cache do
    describe "#fetch" do
      it "cache hit" do
        cache_contents(["k 1", "v 1"])
        expected_cache(["k 1", "v 1"])

        expect(subject.fetch("k 1") { "v 1" }).to eq("v 1")
      end

      it "cache miss" do
        cache_contents(["k 1", "v 1"])
        expected_cache(["k 2", "v 2"], ["k 1", "v 1"])

        expect(subject.fetch("k 2") { "v 2" }).to eq("v 2")
      end

      it "add to top of empty cache" do
        cache_contents
        expected_cache(["k 1", "v 1"])

        expect(subject.fetch("k 1") { "v 1" }).to eq("v 1")
      end

      it "add to top of cache" do
        cache_contents(["k 2", "v 2"])
        expected_cache(["k 1", "v 1"], ["k 2", "v 2"])

        expect(subject.fetch("k 1") { "v 1" }).to eq("v 1")
      end

      it "shuffle to top of cache" do
        cache_contents(["k 2", "v 2"], ["k 1", "v 1"], ["k 3", "v 3"])
        expected_cache(["k 1", "v 1"], ["k 2", "v 2"], ["k 3", "v 3"])

        expect(subject.fetch("k 1") { "v 1" }).to eq("v 1")
      end

      it "enforce cache capacity" do
        cache_contents(["k 1", "v 1"], ["k 2", "v 2"], ["k 3", "v 3"], ["k 4", "v 4"], ["k 5", "v 5"])
        expected_cache(["k 6", "v 6"], ["k 1", "v 1"], ["k 2", "v 2"], ["k 3", "v 3"], ["k 4", "v 4"])

        expect(subject.fetch("k 6") { "v 6" }).to eq("v 6")
      end
    end

    it "handles error loading cache from file" do
      cache_load_error
      expected_cache(["k 1", "v 1"])

      expect(subject.fetch("k 1") { "v 1" }).to eq("v 1")
    end

    def cache_contents(*contents)
      allow(YAML).to receive(:load_file).and_return(contents)
    end

    def expected_cache(*contents)
      allow(Dir).to receive(:home).and_return("home_dir")
      expect(File).to receive(:write).with("home_dir/.nutrella.cache.yml", contents.to_yaml)
    end

    def cache_load_error
      allow(YAML).to receive(:load_file).and_raise
    end
  end
end
