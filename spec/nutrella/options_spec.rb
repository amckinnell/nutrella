require "spec_helper"

module Nutrella
  RSpec.describe Options do
    describe "reads board name from args" do
      it "-t" do
        subject = Options.new(["-t", "board_name"])
        subject.parse

        expect(subject.board_name).to eq("board_name")
      end

      it "--trello-board" do
        subject = Options.new(["--trello-board", "board_name"])
        subject.parse

        expect(subject.board_name).to eq("board_name")
      end
    end

    it "-h" do
      subject = Options.new(["-h"])
      subject.parse

      expect(subject.show_usage?).to eq(true)
    end

    it "derives board name from git branch" do
      allow(Git).to receive_message_chain(:open, :current_branch).and_return("9476_git_branch")

      subject = Options.new([])
      subject.parse

      expect(subject.board_name).to eq("9476 Git Branch")
    end
  end
end
