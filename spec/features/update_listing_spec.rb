feature 'update a listing' do
    scenario 'A user can edit a listing that they have created' do
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
      click_button 'Submit'
      expect(current_path).to eq '/listings'
      click_button 'edit listing'
      fill_in 'name', with: "This is different listing"
      fill_in 'description', with: "Pretty cottage"
      fill_in 'price', with: "750.00"
      fill_in 'dates_available', with: "24/05/24"
      click_button 'Submit'
      expect(current_path).to eq '/listings'
      expect(page).to have_content "This is different listing"


    end
  end
