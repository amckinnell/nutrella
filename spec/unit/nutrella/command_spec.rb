RSpec.describe Nutrella::Command do
  let(:board_name) { "My Board" }
  let(:https_url) { "https://board_url" }
  let(:trello_url) { "trello://board_url" }
  let(:values) { { launch_command: "open $url$", enable_trello_app: false } }

  subject(:command) { Nutrella::Command.new("home_dir", board_name) }

  before do
    allow(command).to receive(:task_board).and_return(configured_task_board)
    allow(command).to receive(:url_cache).and_return(configured_cache)
  end

  it "#cache_filename" do
    expect(command.cache_filename).to eq("home_dir/.nutrella.cache.yml")
  end

  it "#configuration_filename" do
    expect(command.configuration_filename).to eq("home_dir/.nutrella.yml")
  end

  it "#run and launch in browser" do
    values = { launch_command: "open $url$", enable_trello_app: false }
    allow(command).to receive(:configuration_values).and_return(values)

    expect(command).to receive(:system).with("open #{https_url}")

    command.run
  end

  it "#run and launch in Trello app" do
    values = { launch_command: "open $url$", enable_trello_app: true }
    allow(command).to receive(:configuration_values).and_return(values)

    expect(command).to receive(:system).with("open #{trello_url}")

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
        .and_return(instance_double(Trello::Board, url: https_url))
    end
  end
end
