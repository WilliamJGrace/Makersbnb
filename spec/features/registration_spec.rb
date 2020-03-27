feature 'registration' do
  scenario 'A user can sign up' do
    visit '/users/new'
    fill_in('email', with: 'test@example.com')
    fill_in('name', with: 'test')
    fill_in('username', with: 'testing123')
    fill_in('password', with: 'password123')
    click_button('Submit')

    expect(page).to have_content "Welcome, Test"
  end

  scenario 'A user cant sign up with an already used username' do
    visit '/users/new'
    fill_in('email', with: 'test@example.com')
    fill_in('name', with: 'test')
    fill_in('username', with: 'testing123')
    fill_in('password', with: 'password123')
    click_button('Submit')
    visit '/users/new'
    fill_in('email', with: 'test@example.com')
    fill_in('name', with: 'test')
    fill_in('username', with: 'testing123')
    fill_in('password', with: 'password123')
    click_button('Submit')
    expect(page).to have_content "username already taken"




  end
end
