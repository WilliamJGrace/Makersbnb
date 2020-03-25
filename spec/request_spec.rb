require 'Listing'
require 'User'
require 'requests'

describe Requests do
  describe "#create" do
    it "can create a new request" do
      user = User.create(email: "test@makers.com", name: "will", username: "will123", password: "password456")
      listing = Listing.create(user_id: user.id, name: "Peter Stevens", description: "Pandemic and chill, £100.00 a night", price: 700, date_created: "2020/03/24", dates_available: "2020/03/31")
      request = Requests.create(listing_user_id: user.id, requester_user_id: user.id, listing_id: listing.id, name: listing.name, description: listing.description, price: listing.price, dates_booked: '01/01/01 - 02/02/02')
      expect(request).to be_a Requests
      expect(request.listing_user_id).to eq user.id
      expect(request.requester_user_id).to eq user.id
      expect(request.listing_id).to eq listing.id
      expect(request.description).to eq "Pandemic and chill, £100.00 a night"
      expect(request.price).to eq "700.00"
      expect(request.dates_booked).to eq "01/01/01 - 02/02/02"
      

    end


  end
end