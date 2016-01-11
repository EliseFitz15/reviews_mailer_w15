require 'rails_helper'
# Acceptance Test
# [√] Navigating to the /pokemon shows a list of all pokemon
# [√] User must be logged in to see all pokemon

feature "As an authenticated user
  I want to view a list of pokemon
  So that I can pick items to review" do

  scenario "authenticated user sees list" do
    pokemon = FactoryGirl.create(:pokemon)
    sign_in
    visit pokemons_path

    expect(page).to have_content "Pokedex"
    expect(page).to have_content pokemon.name
  end
  scenario "unauthenticated user does not see list" do
    visit pokemons_path

    expect(page).to_not have_content "Pokedex"
    expect(page).to have_content "You need to sign in or sign up before continuing."
  end
end
