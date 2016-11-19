module Nutrella
  RSpec.describe TaskBoardName do
    subject(:task_board_name) { TaskBoardName }

    it "derives the task board name from the current git branch" do
      configure_git_command_success(current_branch: "1234_feature_branch")

      expect(task_board_name.from_git_branch).to eq("1234 Feature Branch")
    end

    it "displays an error when there is no associated git branch" do
      configure_git_command_failure

      expect { task_board_name.from_git_branch }.to output(
        "Sorry. Can't find an associated git branch here.\n")
        .to_stderr.and(raise_error(SystemExit))
    end

    def configure_git_command_success(current_branch:)
      configure_open3(git_branch_name: "#{current_branch}\n", success: true)
    end

    def configure_git_command_failure
      configure_open3(git_branch_name: nil, success: false)
    end

    def configure_open3(git_branch_name:, success:)
      expect(Open3).to receive(:capture2).with('git rev-parse --abbrev-ref HEAD')
        .and_return([git_branch_name, instance_double(Process::Status, success?: success)])
    end
  end
end
