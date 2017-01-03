RSpec.describe Nutrella::DeveloperKeys do
  describe "#open_public_key_url" do
    it "delegate to Trello's #open_public_key_url" do
      expect(Trello).to receive(:open_public_key_url)

      Nutrella.open_public_key_url
    end
  end

  describe "#open_authorization_url" do
    it "delegate to Trello's #open_authorization_url with Nutrella as the requesting application" do
      expect(Trello).to receive(:open_authorization_url).with(expiration: "1day", name: "Nutrella")

      Nutrella.open_authorization_url(expiration: "1day")
    end
  end
end
