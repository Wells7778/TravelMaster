Rails.application.routes.draw do
  devise_for :users

  # routes for admin
  namespace :admin do
    resources :attractions
    resources :users, only: [:index, :update]

    root "attractions#index"
  end
end
