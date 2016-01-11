require 'rails_helper'

feature "As an authenticated user
I want to add an item
So that others can review it" do

  scenario "user adds a pokemon successfully" do
    sign_in
    visit new_pokemon_path

    fill_in 'Name', with: "Psyduck"
    fill_in 'Ability', with: "confusion"
    fill_in 'Poketype', with: "normal"
    fill_in 'Strength', with: 100
    fill_in 'Age', with: 2

    click_on "Add Pokemon"
    expect(page).to have_content "Pokemon successfully added!"
    expect(page).to have_content "Psyduck"
  end

  scenario "user doesn't provide valid information" do
    sign_in
    visit new_pokemon_path

    click_button "Add Pokemon"

    expect(page).to have_content "Name can't be blank. Ability can't be blank. Poketype can't be blank"
    expect(page).to_not have_content "Psyduck"
  end
end
