RSpec.describe Nutrella::TaskBoardName do
  subject(:task_board_name) { Nutrella::TaskBoardName }

  it "derives the task board name from the first command line arg" do
    configure_git_command_failure

    expect(task_board_name.board_name_from_git_branch(["command_line"])).to eq("command_line")
  end

  it "derives the task board name from the current git branch" do
    configure_git_command_success(current_branch: "git_branch")

    expect(task_board_name.board_name_from_git_branch([])).to eq("git_branch")
  end

  it "ignores trailing all caps modifiers from the current git branch" do
    configure_git_command_success(current_branch: "git_branch-SPIKE")

    expect(task_board_name.board_name_from_git_branch([])).to eq("git_branch")
  end

  it "displays an error when there is no command line arg and no current git branch" do
    configure_git_command_failure

    expect { task_board_name.board_name_from_git_branch([]) }.to output(
      "Sorry. Can't figure out a name for the board.\n"
    ).to_stderr.and(raise_error(SystemExit))
  end

  def configure_git_command_success(current_branch:)
    configure_open3(git_branch_name: "#{current_branch}\n", success: true)
  end

  def configure_git_command_failure
    configure_open3(git_branch_name: nil, success: false)
  end

  def configure_open3(git_branch_name:, success:)
    allow(Open3).to receive(:capture2)
      .with("git rev-parse --abbrev-ref HEAD")
      .and_return([git_branch_name, instance_double(Process::Status, success?: success)])
  end
end
