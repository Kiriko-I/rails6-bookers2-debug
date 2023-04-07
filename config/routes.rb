Rails.application.routes.draw do
  devise_for :users

  root to: "homes#top"
  get "home/about" => "homes#about"

  get '/search' => "searches#search"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    member do
      get :followeds, :followers
      resource :relationships, only: [:create, :destroy]
    end
    get "search" => "users#search"
  end

  resources :rooms, only: [:create, :show]
  resources :messages, only: [:create]

  resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
    resource :group_users, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end