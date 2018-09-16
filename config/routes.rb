Rails.application.routes.draw do
  devise_for :users
  root "attractions#index"

  # routes for admin
  namespace :admin do
    resources :categories
    resources :attractions
    resources :users, only: [:index, :update]

    root "attractions#index"
  end
end
