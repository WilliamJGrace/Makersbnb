# feature 'Adding and viewing listings' do
#   feature 'A user can add a listing and then view that listing' do
#     scenario 'A listing is added to the listings page' do
#       # listing = Listing.create(user_id: 55, name: "Peter Stevens", description: "Pandemic and chill, £100.00 a night", price: 700, date_created: "2020/03/24", dates_available: "2020/03/31")

#       visit '/listings'
#       first('.listings').click_button "Add Listing"

#       expect(current_path).to eq "/listings/new"

#       fill_in 'listing', with: "This is a new listing"
#       click_button 'Submit new listing'

#       expect(current_path).to eq '/listings'
#       expect(first('.listings')).to have_content "This is a test listing on this listings page"
#     end
#   end
# end


  