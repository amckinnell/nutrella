module Nutrella
  RSpec.describe TaskBoardNamePolicy do
    it "derives the task board name from the current git branch" do
      allow(Git).to receive_message_chain(:open, :current_branch).and_return("1234_feature_branch")

      expect(TaskBoardNamePolicy.from_git_branch).to eq("1234 Feature Branch")
    end
  end
end
