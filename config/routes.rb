Rails.application.routes.draw do
  resources :leagues
  root to: 'home#index'
  devise_for :users
end
