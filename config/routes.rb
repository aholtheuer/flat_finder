Rails.application.routes.draw do
  devise_for :users
  root "pages#home"
  # get "signup", to: "users#new"
  resources :users, only: [:show, :index]
  resources :search_params

  # get "login", to: "sessions#new"
  # post "login", to: "sessions#create"
  # delete "logout", to: "sessions#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  ##### Sidekiq #######
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app


end
