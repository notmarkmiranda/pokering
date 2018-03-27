Rails.application.routes.draw do
  devise_for :users

  authenticated do
    root to: "secret#index", as: :authenticated_root
  end

  root to: 'home#index'
  resources :leagues do
    resources :seasons do
      resource :activate, only: [:update]
      resource :complete, only: [:update]
    end
  end
end
