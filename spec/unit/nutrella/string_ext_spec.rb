RSpec.describe "String extensions" do
  describe "#titleize" do
    it "removes dashes" do
      git_branch_name = "1234-performance-fix"

      expect(git_branch_name.titleize).to eq("1234 Performance Fix")
    end

    it "removes underscores" do
      git_branch_name = "1234_performance_fix"

      expect(git_branch_name.titleize).to eq("1234 Performance Fix")
    end
  end
end
