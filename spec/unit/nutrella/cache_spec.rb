module Nutrella
  RSpec.describe Cache do
    describe "lookup" do
      it "cache hit" do
        cache_contents(%w(board_1 url_1))

        expect(Cache.lookup("board_1")).to eq("url_1")
      end

      it "cache miss" do
        cache_contents(%w(board_1 url_1))

        expect(Cache.lookup("board_2")).to be_nil
      end
    end

    describe "write" do
      it "add to top of empty cache" do
        cache_contents
        expected_cache(%w(board_1 url_1))

        Cache.write("board_1", "url_1")
      end

      it "add to top of cache" do
        cache_contents(%w(board_2 url_2))
        expected_cache(%w(board_1 url_1), %w(board_2 url_2))

        Cache.write("board_1", "url_1")
      end

      it "shuffle to top of cache" do
        cache_contents(%w(board_2 url_2), %w(board_1 url_1), %w(board_3 url_3))
        expected_cache(%w(board_1 url_1), %w(board_2 url_2), %w(board_3 url_3))

        Cache.write("board_1", "url_1")
      end

      it "cache capacity" do
        cache_contents(%w(board_1 url_1), %w(board_2 url_2), %w(board_3 url_3), %w(board_4 url_4), %w(board_5 url_5))
        expected_cache(%w(board_6 url_6), %w(board_1 url_1), %w(board_2 url_2), %w(board_3 url_3), %w(board_4 url_4))

        Cache.write("board_6", "url_6")
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
