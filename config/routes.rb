Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root to: 'homes#top'
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationship, only: [:show, :create, :destroy]
    member do
      get :followers
      get :followeds
    end
    # get "followers" => "relationships#followers_show"
    # get "followeds" => "relationships#followeds_show"
    # resources :followers, controller: :relationship, only: [:create, :destroy]
    # resources :followeds, controller: :relationship, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
