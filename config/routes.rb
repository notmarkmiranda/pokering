Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'
  resources :leagues do
    resources :seasons do
      resources :games do
        resources :players do
          resource :finish, only: [:update]
        end
        resource :game_over, only: [:update]
      end
      resource :activate, only: [:update]
      resource :complete, only: [:update]
    end
  end
end
