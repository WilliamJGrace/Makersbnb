feature 'Viewing listings' do
  scenario 'A user can see listings' do
    visit('/listings')

    expect(page).to have_content "Lovely house"
    expect(page).to have_content "Romantic get-away"
    expect(page).to have_content "Seaside cottage"
  end
end