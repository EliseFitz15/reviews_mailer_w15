Rails.application.routes.draw do
  root 'pokemons#index'
  devise_for :users
  resources :pokemons, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:index, :new, :create]
  end
end
