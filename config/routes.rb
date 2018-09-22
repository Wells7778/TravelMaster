Rails.application.routes.draw do
  devise_for :users
  root "attractions#index"

  resources :attractions, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
    collection do
      post :search
    end

    member do
      post :like
      post :unlike
    end
  end


  # routes for admin
  namespace :admin do
    resources :categories
    resources :attractions
    resources :users, only: [:index, :update]

    root "attractions#index"
  end
end
