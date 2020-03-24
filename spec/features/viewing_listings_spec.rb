feature 'Viewing listings' do
  scenario 'A user can see listings' do
    visit('/listings')
    user = User.create(email: "test@makers.com", name: "will", username: "will123", password: "password456")
    listing = Listing.create(user_id: user.id, name: "Peter Stevens", description: "Lovely house", price: 700, date_created: "2020/03/24", dates_available: "2020/03/31")
    listing = Listing.create(user_id: user.id, name: "Peter Stevens", description: "Romantic get-away", price: 700, date_created: "2020/03/24", dates_available: "2020/03/31")
    listing = Listing.create(user_id: user.id, name: "Peter Stevens", description: "Seaside cottage", price: 700, date_created: "2020/03/24", dates_available: "2020/03/31")
    listing = Listing.create(user_id: user.id, name: "Peter Stevens", description: "Pandemic and chill", price: 700, date_created: "2020/03/24", dates_available: "2020/03/31")

    expect(page).to have_content "Lovely house"
    expect(page).to have_content "Romantic get-away"
    expect(page).to have_content "Seaside cottage"
    expect(page).to have_content "Pandemic and chill"
  end
end



# @listings = [
#   "Lovely house",
#   "Romantic get-away",
#   "Seaside cottage",
#   "Pandemic and chill"
# ]
