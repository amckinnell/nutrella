module Nutrella
  RSpec.describe TaskBoard do
    let(:options) { double(board_name: "task board name") }

    describe "#new" do
      it "missing configuration" do
        allow(File).to receive(:exist?).and_return(false)

        expect { TaskBoard.new(options, "location") }.to raise_error(
          MissingConfiguration, /location does not exist/)
      end

      it "malformed configuration" do
        allow(File).to receive(:exist?).and_return(true)
        allow(YAML).to receive(:load_file).and_return(username: "<your username>")

        expect { TaskBoard.new(options, "location") }.to raise_error(
          MalformedPath, /location malformed/)
      end
    end
  end
end
