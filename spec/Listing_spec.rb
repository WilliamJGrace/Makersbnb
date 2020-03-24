require 'Listing'

describe Listing do
  describe "#create" do
    it "can create a new listing" do
      listing = Listing.create(user_id: 55, name: "Peter Stevens", description: "Pandemic and chill, £100.00 a night", price: 700, date_created: "2020/03/24", dates_available: "2020/03/31")
      expect(listing).to be_a Listing
      expect(listing.user_id).to eq 55
      expect(listing.name).to eq "Peter Stevens"
      expect(listing.description).to eq "Pandemic and chill, £100.00 a night"
      expect(listing.price).to eq 700
      expect(listing.date_created).to eq "2020/03/24"
      expect(listing.dates_available).to eq "2020/03/31"

    end


  end
end


