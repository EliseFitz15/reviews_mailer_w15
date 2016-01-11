require 'rails_helper'

# Acceptance Criteria
# [] I receive an email when someone reviews my pokemon

feature "As a user
I want to get notified via email
when someone reviews my pokemon" do
  scenario "Email sent if someone reviews a pokemon successfully" do
    user = FactoryGirl.create(:user)
    pokemon = FactoryGirl.create(:pokemon)

    sign_in

    visit pokemon_path(pokemon)
    fill_in "Leave a review", with: "Great in battles"
    fill_in "Rating", with: 5

    click_button "Add Review"
    expect(page).to have_content("Great in battles")
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
