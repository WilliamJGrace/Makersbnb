
feature 'authentication' do
  it 'can let a user sign in' do
    User.create(email: 'test@example.com', name: 'test', username: 'testing123', password: 'password456')

    visit '/login'
    fill_in(:username, with: 'testies123')
    fill_in(:password, with: 'password456')
    click_button('Sign in')
    expect(page).to have_content 'Wrong username or password'
    expect(page).not_to have_content 'Welcome, test'
  end
end
