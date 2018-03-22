Rails.application.routes.draw do
  root to: 'home#index'
  resources :leagues
  devise_for :users
end
