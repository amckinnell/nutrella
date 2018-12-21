RSpec.describe Nutrella::Command do
  let(:board_name) { "My Board" }
  let(:url) { "board_url" }

  subject(:command) { Nutrella::Command.new("home_dir", board_name) }

  it "#cache_filename" do
    expect(command.cache_filename).to eq("home_dir/.nutrella.cache.yml")
  end

  it "#configuration_filename" do
    expect(command.configuration_filename).to eq("home_dir/.nutrella.yml")
  end

  it "#run" do
    allow(command).to receive(:url_cache).and_return(configured_cache)
    allow(command).to receive(:task_board).and_return(configured_task_board)

    expect(command).to receive(:system).with("open #{url}")

    command.run
  end

  def configured_cache
    instance_double(Nutrella::Cache).tap do |cache|
      allow(cache).to receive(:fetch).and_yield
    end
  end

  def configured_task_board
    instance_double(Nutrella::TaskBoard).tap do |task_board|
      allow(task_board).to receive(:lookup_or_create)
        .with(board_name)
        .and_return(instance_double(Trello::Board, url: url))
    end
  end
end
