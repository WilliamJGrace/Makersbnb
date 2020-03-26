feature 'requests' do
  scenario "can create a new request" do
    user = User.create(email: "test@makers.com", name: "will", username: "will123", password: "password456")
    listing = Listing.create(user_id: user.id, name: "Peter Stevens", description: "Pandemic and chill, £100.00 a night", price: 700, dates_available: "2020/03/31")
    request = Requests.create(listing_user_id: user.id, requester_user_id: user.id, listing_id: listing.id, name: listing.name, description: listing.description, price: listing.price, dates_booked: '01/01/01 - 02/02/02')

    visit 'listings/my-requests'
    expect(page).to have_content("Not Confirmed")

  end
end
