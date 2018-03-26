Rails.application.routes.draw do
  root to: 'home#index'
  resources :leagues do
    resources :seasons do
      resource :activate, only: [:update]
      resource :complete, only: [:update]
    end
  end
  devise_for :users
end
