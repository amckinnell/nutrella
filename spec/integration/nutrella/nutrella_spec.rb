module Nutrella
  RSpec.describe "Nutrella" do
    it "creates initial configuration file" do
      Dir.mktmpdir do |home_dir|
        expect { Command.new(home_dir).run }.to(
          output(/you don't have a config file/).to_stderr.and(raise_error(SystemExit))
        )

        expect_contents(configuration_filename(home_dir), initial_configuration)
      end
    end

    it "looks up an existing task board" do
      Dir.mktmpdir do |home_dir|
        create_configuration_file(home_dir)
        arrange_trello_for_lookup(board_name: "My Board", url: "board_url")

        subject = Command.new(home_dir)

        expect(subject).to receive(:system).with("open board_url")

        subject.run
      end
    end

    it "creates a task board" do
      Dir.mktmpdir do |home_dir|
        create_configuration_file(home_dir)
        arrange_trello_for_create(board_name: "My Board", url: "board_url")

        subject = Command.new(home_dir)

        expect(subject).to receive(:system).with("open board_url")

        subject.run
      end
    end

    def create_configuration_file(home_dir)
      File.write(configuration_filename(home_dir), sample_configuration)
    end

    def arrange_trello_for_lookup(board_name:, url:)
      allow(TaskBoardName).to receive(:current_git_branch)
        .and_return(board_name)

      expect(Trello::Action).to receive(:search)
        .with(board_name, anything)
        .and_return("boards" => [board(id: "lookup_id", name: board_name, url: url)])
    end

    def arrange_trello_for_create(board_name:, url:)
      allow(TaskBoardName).to receive(:current_git_branch)
        .and_return(board_name)
      allow(Trello::Action).to receive(:search)
        .with(board_name, anything)
        .and_return("boards" => [])

      expect(Trello::Board).to receive(:create)
        .with(name: board_name, organization_id: TaskBoard::NULOGY_ORGANIZATION_ID)
        .and_return(board(id: "create_id", name: board_name, url: url))
      expect_any_instance_of(Trello::Client).to receive(:put)
        .with("/boards/create_id", "prefs/permissionLevel=org")
    end

    def expect_contents(configuration_filename, expected_configuration)
      expect(File.exist?(configuration_filename)).to eq(true)
      expect(File.read(configuration_filename)).to eq(expected_configuration)
    end

    def configuration_filename(home_dir)
      File.join(home_dir, ".nutrella.yml")
    end

    def board(id:, name:, url:)
      OpenStruct.new(id: id, name: name, url: url)
    end

    def initial_configuration
      <<-YAML.strip_heredoc
        # Trello Developer API Keys
        key: <your developer key>
        secret: <your developer secret>
        token: <your developer token>
      YAML
    end

    def sample_configuration
      <<-YAML.strip_heredoc
        # Trello Developer API Keys
        key: developer_key
        secret: developer_secret
        token: developer_token
      YAML
    end
  end
end
