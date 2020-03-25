feature 'Viewing listings' do
  scenario 'A user can see listings' do
    user = User.create(email: "test@makers.com", name: "will", username: "will123", password: "password456")
    Listing.create(user_id: user.id, name: "Peter Stevens", description: "Lovely house", price: 700, dates_available: "2020/03/31")
    Listing.create(user_id: user.id, name: "Peter Stevens", description: "Romantic get-away", price: 700, dates_available: "2020/03/31")
    Listing.create(user_id: user.id, name: "Peter Stevens", description: "Seaside cottage", price: 700, dates_available: "2020/03/31")
    Listing.create(user_id: user.id, name: "Peter Stevens", description: "Pandemic and chill", price: 700, dates_available: "2020/03/31")
    visit('/listings')
    expect(page).to have_content "Lovely house"
    expect(page).to have_content "Romantic get-away"
    expect(page).to have_content "Seaside cottage"
    expect(page).to have_content "Pandemic and chill"
  end
end
