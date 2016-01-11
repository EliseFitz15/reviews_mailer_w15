require 'factory_girl'

FactoryGirl.define do
  factory :user do
    first_name "Ash"
    last_name "Catchem"
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :pokemon do
    name "Bulbasaur"
    ability "Overgrow"
    poketype "Grass"
    strength 25
    age 2
    user
  end

  factory :review do
    user
    pokemon
    body "Great in battles against watertypes"
    rating 5
  end
end
