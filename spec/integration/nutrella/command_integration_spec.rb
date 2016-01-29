module Nutrella
  vcr_options = { cassette_name: "command", record: :new_episodes }

  RSpec.describe Command, vcr: vcr_options do
    it "finds an existing board" do
      task_board_name = "Nutrella"
      subject = command("-t", task_board_name)

      task_board = subject.run

      expect(task_board).to have_attributes(name: "Nutrella")
    end

    it "creates a new board" do
      task_board_name = "nutrella_new_task_board"
      subject = command("-t", task_board_name)

      allow(subject).to receive(:confirm_create?).and_return("yes")

      task_board = subject.run

      expect(task_board).to have_attributes(name: task_board_name)
    end

    def command(*args)
      Command.new(args)
    end
  end
end
