module Nutrella
  RSpec.describe Cache do
    let(:configuration_directory) { "home_dir" }
    let(:subject) { Cache.new(configuration_directory, 3) }

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
        cache_contents(["k 1", "v 1"], ["k 2", "v 2"], ["k 3", "v 3"])
        expected_cache(["k 4", "v 4"], ["k 1", "v 1"], ["k 2", "v 2"])

        expect(subject.fetch("k 4") { "v 4" }).to eq("v 4")
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
      expect(File).to receive(:write).with(path, contents.to_yaml)
    end

    def cache_load_error
      allow(YAML).to receive(:load_file).and_raise
    end

    def path
      File.join(configuration_directory, Cache::CACHE_FILENAME)
    end
  end
end
