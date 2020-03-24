feature 'Creating listings' do
    scenario 'A listing is added to the listings page' do
      visit('/listings')
      # create(user_id:, name:, description:, price:, date_created:, dates_available:)
      first('.listings').click_button "Add Listing"
      expect(current_path).to eq "/listings/#{listings.id}/new"
      fill_in 'listing', with: "This is a new listing"
      click_button 'Submit'
      expect(current_path).to eq '/listings'
      expect(first('.listings')).to have_content "This is a test listing"
    end
  end
