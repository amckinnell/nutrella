module Nutrella
  RSpec.describe TaskBoardName do
    it "derives the task board name from the current git branch" do
      allow(Git).to receive_message_chain(:open, :current_branch).and_return("1234_feature_branch")

      expect(TaskBoardName.from_git_branch(".")).to eq("1234 Feature Branch")
    end

    it "displays an error when there is no associated git branch" do
      Dir.mktmpdir do |non_git_dir|
        expect { TaskBoardName.from_git_branch(non_git_dir) }.to output(
          /Can't find an associated git branch/).to_stderr.and(raise_error(SystemExit))
      end
    end
  end
end
