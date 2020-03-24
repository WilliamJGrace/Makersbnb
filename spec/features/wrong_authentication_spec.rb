
feature 'authentication' do
  it 'can not let a user sign in with wrong username' do
    User.create(email: 'test@example.com', name: 'test', username: 'testing123', password: 'password456')

    visit '/login'
    fill_in(:username, with: 'testies123')
    fill_in(:password, with: 'password456')
    click_button('Sign in')
    expect(page).to have_content 'Wrong username or password'
    expect(page).not_to have_content 'Welcome, test'
  end

  it 'can not let a user sign in with wrong password' do
    User.create(email: 'test@example.com', name: 'test', username: 'testing123', password: 'password456')

    visit '/login'
    fill_in(:username, with: 'testing123')
    fill_in(:password, with: 'password459')
    click_button('Sign in')
    expect(page).to have_content 'Wrong username or password'
    expect(page).not_to have_content 'Welcome, test'
  end
end
