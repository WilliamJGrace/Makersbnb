feature 'registration' do
  scenario 'A user can sign up' do
    visit '/users/new' 
    fill_in('email', with: 'test@example.com')
    fill_in('name', with: 'test')
    fill_in('username', with: 'testing123')
    fill_in('password', with: 'password123')
    click_button('Submit')

    expect(page).to have_content "Welcome, test"
  end
end