RSpec.describe Nutrella::BoardNameResolver do
  let(:url) { "https://trello.com/b/DErq70Xp/PM-1234-description" }
  let(:url_cache) { instance_double(Nutrella::Cache) }

  it "finds matching url" do
    allow(url_cache).to receive(:search).with(/PM-1234-description/i).and_return(url)

    resolved_url = resolve(search_specification: /PM-1234/, board_name: "PM-1234-description")

    expect(resolved_url).to eq(url)
  end

  it "falls back to the url cache" do
    allow(url_cache).to receive(:search).with(/PM-1234-description/i).and_return(nil)
    allow(url_cache).to receive(:fetch).with("PM-1234-description").and_return(url)

    resolved_url = resolve(search_specification: /PM-1234/, board_name: "PM-1234-description")

    expect(resolved_url).to eq(url)
  end

  def resolve(search_specification:, board_name:, &block)
    described_class.new(url_cache, search_specification).resolve(board_name, &block)
  end
end
