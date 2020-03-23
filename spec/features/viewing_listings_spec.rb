feature 'Viewing listings' do
  scenario 'A user can see listings' do
    visit('/listings')

    expect(page).to have_content "Lovely house"
    expect(page).to have_content "Romantic get-away"
    expect(page).to have_content "Seaside cottage"
    expect(page).to have_content "Pandemic and chill"
  end
end



# @listings = [
#   "Lovely house",
#   "Romantic get-away",
#   "Seaside cottage", 
#   "Pandemic and chill"
# ]