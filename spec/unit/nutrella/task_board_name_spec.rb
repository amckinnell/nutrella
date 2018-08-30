RSpec.describe Nutrella::TaskBoardName do
  subject(:task_board_name) { Nutrella::TaskBoardName }

  it "derives the task board name from the current git branch" do
    configure_git_command_success(current_branch: "git_branch")

    expect(task_board_name.board_name(["command_line"])).to eq("git_branch")
  end

  it "derives the task board name from the first command line arg" do
    configure_git_command_failure

    expect(task_board_name.board_name(["command_line"])).to eq("command_line")
  end

  it "displays an error when there is no argument" do
    configure_git_command_failure

    expect { task_board_name.board_name([]) }.to output(
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
    expect(Open3).to receive(:capture2)
      .with("git rev-parse --abbrev-ref HEAD")
      .and_return([git_branch_name, instance_double(Process::Status, success?: success)])
  end
end
