Rails.application.routes.draw do
  resources :players
  devise_for :users

  root to: 'home#index'
  resources :leagues do
    resources :seasons do
      resources :games
      resource :activate, only: [:update]
      resource :complete, only: [:update]
    end
  end
end
