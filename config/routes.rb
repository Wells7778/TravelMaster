Rails.application.routes.draw do
  devise_for :users
  resources :attractions, only: [:index, :show] do
    resources :reviews, except: [:index, :destroy]
    collection do
      post :search
    end
  end
  root "attractions#index"

  get "/reviews", to:"reviews#index"
  get "/mytrips", to: "attractions#mytrips"

  # routes for admin
  namespace :admin do
    resources :categories
    resources :attractions
    resources :users, only: [:index, :update]

    root "attractions#index"
  end
end
