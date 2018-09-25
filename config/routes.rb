Rails.application.routes.draw do
  devise_for :users
  root "attractions#index"

  resources :attractions, only: [:index, :show] do
    resources :reviews, except: [:index, :destroy]
    collection do
      post :search
      post :create_comment, to: "comments#create"
      post :destroy_comment, to: "comments#destroy"
    end

    member do
      post :like
      post :unlike
    end
  end


  get "/reviews", to:"reviews#index"
  get "/mytrips", to: "attractions#mytrips"
  get "/about", to: "attractions#about"

  # routes for admin
  namespace :admin do
    resources :categories
    resources :attractions
    resources :users, only: [:index, :update]

    root "attractions#index"
  end
end
