module Nutrella
  RSpec.describe TaskBoardName do
    subject { TaskBoardName }

    describe "derives the task board name from the current git branch" do
      it "given a directory" do
        configure_git(working_dir: "dir", current_branch: "master")

        expect(subject.from_git_branch("dir")).to eq("Master")
      end

      it "defaulting to the current directory" do
        configure_git(working_dir: ".", current_branch: "1234_feature_branch")

        expect(subject.from_git_branch).to eq("1234 Feature Branch")
      end
    end

    it "displays an error when there is no associated git branch" do
      Dir.mktmpdir do |non_git_dir|
        expect { subject.from_git_branch(non_git_dir) }.to output(
          /Can't find an associated git branch/).to_stderr.and(raise_error(SystemExit))
      end
    end

    def configure_git(working_dir:, current_branch:)
      allow(Git).to receive(:open).with(working_dir).and_return(
        instance_double(Git::Base, current_branch: current_branch))
    end
  end
end
