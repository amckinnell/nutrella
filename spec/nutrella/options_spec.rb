require "spec_helper"

module Nutrella
  RSpec.describe Options do
    describe "reads task board name from args" do
      it "-t" do
        subject = options_parse("-t", "task_board_name")

        expect(subject.board_name).to eq("task_board_name")
      end

      it "--trello-board" do
        subject = options_parse("--trello-board", "task_board_name")

        expect(subject.board_name).to eq("task_board_name")
      end
    end

    describe "display usage" do
      it "-h" do
        subject = options_parse("-h")

        expect(subject.show_usage?).to eq(true)
      end

      it "--help" do
        subject = options_parse("--help")

        expect(subject.show_usage?).to eq(true)
      end
    end

    it "derives board name from the current git branch" do
      allow(Git).to receive_message_chain(:open, :current_branch).and_return("9476_git_branch")

      subject = options_parse

      expect(subject.board_name).to eq("9476 Git Branch")
    end

    def options_parse(*opts)
      Options.new(opts).tap do |options|
        silence_stream(STDOUT) { options.parse }
      end
    end
  end
end
