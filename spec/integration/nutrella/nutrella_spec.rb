require "tmpdir"

RSpec.describe "Nutrella" do
  let(:board_name) { "My Board" }
  let(:url) { "board_url" }
  let(:board) { instance_double(Trello::Board, id: "id", name: board_name, url: url) }

  it "creates initial configuration file" do
    create_command do |command|
      expect { command.run }.to output(/you don't have a config file/).to_stderr.and(raise_error(SystemExit))
      expect(command).to have_configuration(Nutrella::Configuration::INITIAL_CONFIGURATION)
    end
  end

  it "looks up an existing task board" do
    create_command do |command|
      create_sample(command.configuration_filename)
      trello_search(board_name, search_result: [board])

      expect(command).to receive(:system).with("open #{url}")

      command.run
    end
  end

  it "creates a task board" do
    create_command do |command|
      create_sample(command.configuration_filename)
      trello_search(board_name, search_result: [])

      expect(Trello::Board).to receive(:create)
        .with(name: board_name, organization_id: "developer_organization")
        .and_return(board)

      expect_any_instance_of(Trello::Client).to receive(:put)
        .with("/boards/#{board.id}", "prefs/permissionLevel=org")

      expect(command).to receive(:system).with("open #{url}")

      command.run
    end
  end

  def create_command
    Dir.mktmpdir { |home_dir| yield Nutrella::Command.new(home_dir, board_name) }
  end

  def trello_search(board_name, search_result:)
    allow(Trello::Action).to receive(:search)
      .with(board_name, modelTypes: "boards", board_fields: "all")
      .and_return("boards" => search_result)
  end

  def create_sample(configuration_filename)
    File.write(configuration_filename, <<-SAMPLE.strip_heredoc)
        # Trello Developer API Keys
        key: developer_key
        secret: developer_secret
        token: developer_token

        # Optional Configuration
        organization: developer_organization
    SAMPLE
  end

  RSpec::Matchers.define :have_configuration do |expected_configuration|
    match do |command|
      expect(File.exist?(command.configuration_filename)).to eq(true)
      expect(File.read(command.configuration_filename)).to eq(expected_configuration)
    end
  end
end
