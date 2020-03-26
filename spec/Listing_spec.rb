require 'Listing'
require 'User'

describe Listing do
  describe ".create" do
    it "can create a new listing" do
      user = User.create(email: "test@makers.com", name: "will", username: "will123", password: "password456")
      listing = Listing.create(user_id: user.id, name: "Peter Stevens", description: "Pandemic and chill, £100.00 a night", price: 700, dates_available: "2020/03/31")
      expect(listing).to be_a Listing
      expect(listing.user_id).to eq user.id
      expect(listing.name).to eq "Peter Stevens"
      expect(listing.description).to eq "Pandemic and chill, £100.00 a night"
      expect(listing.price).to eq "700.00"
      expect(listing.date_created).to eq "#{Time.now}"
      expect(listing.dates_available).to eq "2020/03/31"

    end
  end
  describe ".update" do
    it "updates the listing with the new data" do
      user = User.create(email: "test@makers.com", name: "will", username: "will123", password: "password456")
      listing = Listing.create(user_id: user.id, name: "Peter Stevens", description: "Pandemic and chill, £100.00 a night", price: 700, dates_available: "2020/03/31")
      updated_listing = Listing.update(id: listing.id, name: "Luxury Villa", description: "a sunny retreat", price: 900, dates_available: "2020/04/66")
      expect(updated_listing.id).to eq listing.id
      expect(updated_listing).to be_a Listing
      expect(updated_listing.user_id).to eq user.id
    end
  end
  describe ".delete" do
    it "can delete a new listing" do
      user = User.create(email: "test@makers.com", name: "will", username: "will123", password: "password456")
      listing = Listing.create(user_id: user.id, name: "Peter Stevens", description: "Pandemic and chill, £100.00 a night", price: 700, dates_available: "2020/03/31")
      listing = Listing.delete(id: listing.id)
      expect(Listing.all.length).to eq 0

    end
end
end
