module Nutrella
  vcr_options = { cassette_name: "command", record: :new_episodes }

  RSpec.describe Command, vcr: vcr_options do
    pending
  end
end
