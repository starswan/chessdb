Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'openings#index'

  resources :openings do
    resources :games, only: :index, controller: 'openings/games'
  end
  resources :games do
    resources :moves, only: :index
  end
  resources :moves, except: :index
  resources :players do
    resources :games, only: :index, controller: 'players/games'
  end
end
