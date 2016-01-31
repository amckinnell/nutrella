module Nutrella
  RSpec.describe TaskBoard do
    let(:options) { double(board_name: "task board name") }

    describe "#new" do
      it "missing configuration" do
        allow(File).to receive(:exist?).and_return(false)
        allow(Configuration).to receive(:location).and_return("location")

        expect { TaskBoard.new(options) }.to raise_error(RuntimeError, /location does not exist/)
      end

      it "malformed configuration" do
        allow(File).to receive(:exist?).and_return(true)
        allow(Configuration).to receive(:location).and_return("location")
        allow(YAML).to receive(:load_file).and_return(username: "<your username>")

        expect { TaskBoard.new(options) }.to raise_error(RuntimeError, /location malformed/)
      end
    end
  end
end
