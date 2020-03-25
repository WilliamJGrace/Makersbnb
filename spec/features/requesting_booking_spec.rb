feature 'requesting booking' do
  scenario 'A user can request a booking' do
    user = User.create(email: "test@makers.com", name: "will", username: "will123", password: "password456")
    Listing.create(user_id: user.id, name: "Peter Stevens", description: "Lovely house", price: 700, date_created: "2020/03/24", dates_available: "2020/03/31")
    visit '/login'
    fill_in(:username, with: 'will123')
    fill_in(:password, with: 'password456')
    click_button('Sign in')

    visit('/listings')
    
    click_button('Request this listing')
    expect(page).to have_content("Hello")
  end
end