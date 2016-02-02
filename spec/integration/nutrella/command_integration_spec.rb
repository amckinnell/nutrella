module Nutrella
  vcr_options = { cassette_name: "nutrella", record: :new_episodes }

  RSpec.describe "Nutrella", vcr: vcr_options do
    it "finds an existing board" do
      task_board_name = "Nutrella"
      subject = command("-t", task_board_name)

      task_board = subject.task_board

      expect(task_board).to have_attributes(name: task_board_name)
    end

    it "creates a new board" do
      task_board_name = "nutrella_new_task_board"
      subject = command("-t", task_board_name)

      allow(subject).to receive(:confirm_create?).and_return(true)

      task_board = subject.task_board

      expect(task_board).to have_attributes(name: task_board_name)
    end

    it "displays the version" do
      subject = command("-v")

      expect { subject.task_board }.to output(/#{Nutrella::VERSION}/).to_stdout
    end

    it "displays the usage" do
      subject = command("-h")

      expect { subject.task_board }.to output(/Usage:/).to_stdout
    end

    def command(*args)
      Command.new(Options.new(args))
    end
  end
end
