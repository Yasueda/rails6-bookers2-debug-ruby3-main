Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root to: 'homes#top'
  get "home/about"=>"homes#about"

  get 'search' => 'searches#search'
  get 'search_tag' => 'searches#search_tag'

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorite, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationship, only: [:show, :create, :destroy]
    member do
      get :followers
      get :followeds
      get :datebooks
    end
  end

  resources :chats, only: [:show, :create, :destroy]
  resources :groups, only: [:new, :index, :show, :edit, :update, :create, :destroy] do
    member do
      get :join
      get :leave
      get :notice
    end
  end
end
