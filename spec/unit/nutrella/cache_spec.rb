RSpec.describe Nutrella::Cache do
  let(:cache_path) { "cache_path" }

  subject(:cache) { Nutrella::Cache.new(cache_path, 3) }

  describe "#fetch" do
    it "cache hit" do
      cache_contents(["k 1", "v 1"])
      expected_cache(["k 1", "v 1"])

      expect(cache.fetch("k 1") { "v 1" }).to eq("v 1")
    end

    it "cache hit with alternate value" do
      cache_contents(["k 1", "v 1"])
      expected_cache(["k 1", "v 1"])

      expect(cache.fetch("k 1") { "alternate value" }).to eq("v 1")
    end

    it "cache miss" do
      cache_contents(["k 1", "v 1"])
      expected_cache(["k 2", "v 2"], ["k 1", "v 1"])

      expect(cache.fetch("k 2") { "v 2" }).to eq("v 2")
    end

    it "add to top of empty cache" do
      cache_contents
      expected_cache(["k 1", "v 1"])

      expect(cache.fetch("k 1") { "v 1" }).to eq("v 1")
    end

    it "add to top of cache" do
      cache_contents(["k 2", "v 2"])
      expected_cache(["k 1", "v 1"], ["k 2", "v 2"])

      expect(cache.fetch("k 1") { "v 1" }).to eq("v 1")
    end

    it "shuffle to top of cache" do
      cache_contents(["k 2", "v 2"], ["k 1", "v 1"], ["k 3", "v 3"])
      expected_cache(["k 1", "v 1"], ["k 2", "v 2"], ["k 3", "v 3"])

      expect(cache.fetch("k 1") { "v 1" }).to eq("v 1")
    end

    it "enforce cache capacity" do
      cache_contents(["k 1", "v 1"], ["k 2", "v 2"], ["k 3", "v 3"])
      expected_cache(["k 4", "v 4"], ["k 1", "v 1"], ["k 2", "v 2"])

      expect(cache.fetch("k 4") { "v 4" }).to eq("v 4")
    end
  end

  it "handles error loading cache from file" do
    cache_load_error
    expected_cache(["k 1", "v 1"])

    expect(cache.fetch("k 1") { "v 1" }).to eq("v 1")
  end

  def cache_contents(*contents)
    allow(YAML).to receive(:load_file).with(cache_path).and_return(contents)
  end

  def expected_cache(*contents)
    expect(File).to receive(:write).with(cache_path, contents.to_yaml)
  end

  def cache_load_error
    allow(YAML).to receive(:load_file).with(cache_path).and_raise
  end
end
