module Nutrella
  vcr_options = { cassette_name: "nutrella", record: :new_episodes }

  RSpec.describe "Nutrella", vcr: vcr_options do
    it "finds an existing board" do
      subject = command("-t", "Nutrella")

      task_board = subject.task_board

      expect(task_board).to have_attributes(url: "https://trello.com/b/bqxSqUDM/nutrella")
    end

    it "creates a new board" do
      subject = command("-t", "fresh_task_board")

      allow(subject).to receive(:confirm_create?).and_return(true)

      task_board = subject.task_board

      expect(task_board).to have_attributes(url: match(/https:.*fresh-task-board/))
    end

    it "fails when options don't parse" do
      expect { Command.new(["--invalid-option"]).task_board }.to(
        output(/Error: invalid option/).to_stderr.and(raise_error(SystemExit))
      )
    end

    def command(*args)
      Command.new(args)
    end
  end
end
