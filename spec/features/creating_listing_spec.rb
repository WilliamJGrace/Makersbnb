feature 'Creating listings' do
    scenario 'A listing is added to the listings page' do
      user = User.create(email: 'test@example.com', name: 'test', username: 'testing123', password: 'password456')
      visit '/login'
      fill_in(:username, with: 'testing123')
      fill_in(:password, with: 'password456')
      click_button('Sign in')
      visit('/listings')
      click_button "Add Listing"
      expect(current_path).to eq "/listings/#{user.id}/new"
      fill_in 'name', with: "This is a new listing"
      fill_in 'description', with: "Lovely cottage"
      fill_in 'price', with: "700.00"
      fill_in 'dates_available', with: "24/03/2020"
      fill_in 'img_url', with: "https://www.carehome.co.uk/photos/gallery/large/10002514BREA-1.jpg"
      click_button 'Submit'
      expect(current_path).to eq '/listings'
      expect(page).to have_content "This is a new listing"
    end
  end
