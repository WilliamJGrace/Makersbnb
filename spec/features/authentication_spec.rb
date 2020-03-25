
feature 'authentication' do
  it 'can let a user sign in' do
    User.create(email: 'test@example.com', name: 'test', username: 'testing123', password: 'password456')

    visit '/login'
    fill_in(:username, with: 'testing123')
    fill_in(:password, with: 'password456')
    click_button('Sign in')
    expect(page).to have_content 'Welcome, test'
  end

  it 'can let a user sign out' do
    User.create(email: 'test@example.com', name: 'test', username: 'testing123', password: 'password456')

    visit '/login'
    fill_in(:username, with: 'testing123')
    fill_in(:password, with: 'password456')
    click_button('Sign in')
    click_button('Sign out') 

    expect(page).not_to have_content 'Welcome, test'
    expect(page).to have_content 'You have signed out'
  end
end