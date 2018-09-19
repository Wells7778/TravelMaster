Rails.application.routes.draw do
  devise_for :users
  resources :attractions, only: [:index, :show] do
    collection do
      post :search
    end
  end
  root "attractions#index"

  # routes for admin
  namespace :admin do
    resources :categories
    resources :attractions
    resources :users, only: [:index, :update]

    root "attractions#index"
  end
end
