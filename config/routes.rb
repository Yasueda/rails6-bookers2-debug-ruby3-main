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
  end

  get 'search' => 'searches#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
