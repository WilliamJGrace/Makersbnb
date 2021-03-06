require 'Listing'
require 'User'
require 'requests'

describe Requests do
  describe "#create" do
    it "can create a new request" do
      user = User.create(email: "test@makers.com", name: "will", username: "will123", password: "password456")
      listing = Listing.create(user_id: user.id, name: "Peter Stevens", description: "Pandemic and chill, £100.00 a night", price: 700, dates_available: "2020/03/31", img_url: "https://www.carehome.co.uk/photos/gallery/large/10002514BREA-1.jpg")
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

  describe "#all" do
    it "can show all listings" do
      user = User.create(email: "test@makers.com", name: "will", username: "will123", password: "password456")
      listing = Listing.create(user_id: user.id, name: "Peter Stevens", description: "Pandemic and chill, £100.00 a night", price: 700, dates_available: "2020/03/31", img_url: "https://www.carehome.co.uk/photos/gallery/large/10002514BREA-1.jpg")
      Requests.create(listing_user_id: user.id, requester_user_id: user.id, listing_id: listing.id, name: listing.name, description: listing.description, price: listing.price, dates_booked: '01/01/01 - 02/02/02')
      request = Requests.all
      expect(request[0]).to be_a Requests
      expect(request[0].listing_user_id).to eq user.id
      expect(request[0].requester_user_id).to eq user.id
      expect(request[0].listing_id).to eq listing.id
      expect(request[0].description).to eq "Pandemic and chill, £100.00 a night"
      expect(request[0].price).to eq "700.00"
      expect(request[0].dates_booked).to eq "01/01/01 - 02/02/02"
    end
  end

  describe '.confirm_booking' do
    it "can confirm a request to a booking" do
      user = User.create(email: "test@makers.com", name: "will", username: "will123", password: "password456")
      listing = Listing.create(user_id: user.id, name: "Peter Stevens", description: "Pandemic and chill, £100.00 a night", price: 700, dates_available: "2020/03/31", img_url: "https://www.carehome.co.uk/photos/gallery/large/10002514BREA-1.jpg")
      request = Requests.create(listing_user_id: user.id, requester_user_id: user.id, listing_id: listing.id, name: listing.name, description: listing.description, price: listing.price, dates_booked: '01/01/01 - 02/02/02')
      confirmed_booking = Requests.confirm_booking(id: request.id)
      expect(confirmed_booking.isConfirmed).to eq "t"
    end

  end

  describe '.delete_request' do
    it "can delete a request" do
      user = User.create(email: "test@makers.com", name: "will", username: "will123", password: "password456")
      listing = Listing.create(user_id: user.id, name: "Peter Stevens", description: "Pandemic and chill, £100.00 a night", price: 700, dates_available: "2020/03/31", img_url: "https://www.carehome.co.uk/photos/gallery/large/10002514BREA-1.jpg")
      request = Requests.create(listing_user_id: user.id, requester_user_id: user.id, listing_id: listing.id, name: listing.name, description: listing.description, price: listing.price, dates_booked: '01/01/01 - 02/02/02')
      deleted_request = Requests.delete_request(id: request.id)
      expect(Requests.all.length).to eq 0
    end
  end
end
