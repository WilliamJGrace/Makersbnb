feature 'deleting a listing' do
  it "can let a user delete a listing" do
    user = User.create(email: 'test@example.com', name: 'test', username: 'testing123', password: 'password456')
    visit '/login'
    fill_in(:username, with: 'testing123')
    fill_in(:password, with: 'password456')
    click_button('Sign in')
    visit('/listings')
    click_button "Add Listing"
    fill_in 'name', with: "This is a new listing"
    fill_in 'description', with: "Lovely cottage"
    fill_in 'price', with: "700.00"
    fill_in 'dates_available', with: "24/03/2020"
    click_button 'Submit'
    click_button 'Delete'
    
    expect(page).to_not have_content "Lovely cottage"

end
end
