module Nutrella
  RSpec.describe TaskBoardName do
    it "derives the task board name from the current git branch" do
      allow(Git).to receive_message_chain(:open, :current_branch).and_return("1234_feature_branch")

      expect(TaskBoardName.current_git_branch).to eq("1234 Feature Branch")
    end
  end
end
