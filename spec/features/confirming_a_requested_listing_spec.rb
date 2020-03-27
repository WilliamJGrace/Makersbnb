feature 'requesting booking' do
  scenario 'A user can request a booking' do
    user = User.create(email: "test@makers.com", name: "will", username: "will123", password: "password456")
    # Listing.create(user_id: user.id, name: "Peter Stevens", description: "Lovely house", price: 700, dates_available: "2020/03/31")
    visit '/login'
    fill_in(:username, with: 'will123')
    fill_in(:password, with: 'password456')
    click_button('Sign in')
    click_button "Add Listing"
    fill_in 'name', with: "This is a new listing"
    fill_in 'description', with: "Lovely cottage"
    fill_in 'price', with: "700.00"
    fill_in 'dates_available', with: "24/03/2020"
    click_button 'Submit'
    user = User.create(email: "requester@makers.com", name: "requester", username: "requester123", password: "password123")
    visit '/login'
    fill_in(:username, with: 'requester123')
    fill_in(:password, with: 'password123')
    click_button('Sign in')
    click_button('Request this listing')
    visit '/login'
    fill_in(:username, with: 'will123')
    fill_in(:password, with: 'password456')
    click_button('Sign in')
    click_button('My requests')
    click_button('Accept this request')
    expect(page).to have_content("Booking is confirmed")




  end
end
