Rails.application.routes.draw do
  devise_for :users

  # routes for admin
  namespace :admin do
    resources :users, only: [:index, :update]

    root "users#index"
  end
end
