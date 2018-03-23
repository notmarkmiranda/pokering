Rails.application.routes.draw do
  root to: 'home#index'
  resources :leagues do
    resources :seasons
  end
  devise_for :users
end
