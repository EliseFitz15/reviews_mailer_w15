require 'rails_helper'

feature "As an authenticated user
I want to leave a review for a specific Pokemon
so that others can get feedback about their Pokemon" do
  scenario 'user adds a review successfully' do
    @pokemon = FactoryGirl.create(:pokemon)

    sign_in
    visit pokemon_path(@pokemon)

    fill_in "Leave a review", with: "Great in battles"
    fill_in "Rating", with: 5

    click_button "Add Review"

    expect(page).to have_content "Great in battles"
  end

  scenario 'user adds a review unsuccessfully' do
    @pokemon = FactoryGirl.create(:pokemon)

    sign_in
    visit pokemon_path(@pokemon)
    click_button "Add Review"

    expect(page).to have_content "Body can't be blank. Rating is not a number"
    expect(page).to_not have_content "Great in battles"
  end
end
