module Nutrella
  RSpec.describe Cache do
    describe "lookup" do
      it "cache hit" do
        cache_contents(["b 1", "url 1"])

        expect(Cache.lookup("b 1")).to eq("url 1")
      end

      it "cache miss" do
        cache_contents(["b 1", "url 1"])

        expect(Cache.lookup("b 2")).to be_nil
      end
    end

    describe "write" do
      it "add to top of empty cache" do
        cache_contents
        expected_cache(["b 1", "url 1"])

        Cache.write("b 1", "url 1")
      end

      it "add to top of cache" do
        cache_contents(["b 2", "url 2"])
        expected_cache(["b 1", "url 1"], ["b 2", "url 2"])

        Cache.write("b 1", "url 1")
      end

      it "shuffle to top of cache" do
        cache_contents(["b 2", "url 2"], ["b 1", "url 1"], ["b 3", "url 3"])
        expected_cache(["b 1", "url 1"], ["b 2", "url 2"], ["b 3", "url 3"])

        Cache.write("b 1", "url 1")
      end

      it "cache capacity" do
        cache_contents(["b 1", "url 1"], ["b 2", "url 2"], ["b 3", "url 3"], ["b 4", "url 4"], ["b 5", "url 5"])
        expected_cache(["b 6", "url 6"], ["b 1", "url 1"], ["b 2", "url 2"], ["b 3", "url 3"], ["b 4", "url 4"])

        Cache.write("b 6", "url 6")
      end
    end

    it "path" do
      allow(Dir).to receive(:home).and_return("home_dir")

      expect(Cache.path).to eq("home_dir/#{Cache::CACHE_FILENAME}")
    end

    def cache_contents(*contents)
      allow(YAML).to receive(:load_file).and_return(contents)
    end

    def expected_cache(*contents)
      expect_any_instance_of(File).to receive(:write).with(contents.to_yaml)
    end
  end
end
