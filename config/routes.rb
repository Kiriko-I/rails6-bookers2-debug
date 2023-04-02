Rails.application.routes.draw do

  root to: "homes#top"
  get "home/about"=>"homes#about"
  
  get '/search'=>"searches#search"

  devise_for :users

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    member do
      get :followeds, :followers
      resource :relationships, only: [:create, :destroy]
    end
  end
  
  resources :rooms, only: [:create, :show]
  resources :messages, only: [:create]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end