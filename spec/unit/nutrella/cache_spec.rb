module Nutrella
  RSpec.describe Cache do
    describe "#get" do
      it "cache hit" do
        cache_contents(["b 1", "url 1"])
        expected_cache(["b 1", "url 1"])

        expect(subject.get("b 1") { "url 1" }).to eq("url 1")
      end

      it "cache miss" do
        cache_contents(["b 1", "url 1"])
        expected_cache(["b 2", "url 2"], ["b 1", "url 1"])

        expect(subject.get("b 2") { "url 2" }).to eq("url 2")
      end
    end

    describe "#put" do
      it "add to top of empty cache" do
        cache_contents
        expected_cache(["b 1", "url 1"])

        expect(subject.put("b 1") { "url 1" }).to eq("url 1")
      end

      it "add to top of cache" do
        cache_contents(["b 2", "url 2"])
        expected_cache(["b 1", "url 1"], ["b 2", "url 2"])

        expect(subject.put("b 1") { "url 1" }).to eq("url 1")
      end

      it "shuffle to top of cache" do
        cache_contents(["b 2", "url 2"], ["b 1", "url 1"], ["b 3", "url 3"])
        expected_cache(["b 1", "url 1"], ["b 2", "url 2"], ["b 3", "url 3"])

        expect(subject.put("b 1") { "url 1" }).to eq("url 1")
      end

      it "enforce cache capacity" do
        cache_contents(["b 1", "url 1"], ["b 2", "url 2"], ["b 3", "url 3"], ["b 4", "url 4"], ["b 5", "url 5"])
        expected_cache(["b 6", "url 6"], ["b 1", "url 1"], ["b 2", "url 2"], ["b 3", "url 3"], ["b 4", "url 4"])

        expect(subject.put("b 6") { "url 6" }).to eq("url 6")
      end
    end

    def cache_contents(*contents)
      allow(YAML).to receive(:load_file).and_return(contents)
    end

    def expected_cache(*contents)
      allow(Dir).to receive(:home).and_return("home_dir")
      expect(File).to receive(:write).with("home_dir/.nutrella.cache.yml", contents.to_yaml)
    end
  end
end
