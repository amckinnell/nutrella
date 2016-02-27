module Nutrella
  extend DeveloperKeys

  RSpec.describe DeveloperKeys do
    let(:nutrella) { Nutrella.new { extend DeveloperKeys } }

    describe "#open_public_key_url" do
      it "show Nutrella as the application requesting access in the Trello oauth page" do
        expect(Trello).to receive(:open_public_key_url)

        Nutrella.open_public_key_url
      end
    end

    describe "#open_authorization_url" do
      it "show Nutrella as the application requesting access in the Trello oauth page" do
        expect(Trello).to receive(:open_authorization_url).with(name: "Nutrella")

        Nutrella.open_authorization_url
      end

      it "merge application name into existing options" do
        expect(Trello).to receive(:open_authorization_url).with(expiration: "1day", name: "Nutrella")

        Nutrella.open_authorization_url(expiration: "1day")
      end
    end
  end
end
