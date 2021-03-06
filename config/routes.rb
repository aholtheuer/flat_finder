Rails.application.routes.draw do
  root "pages#home"
  # get "users/:id", to: "users#show"
  # get "users", to: "users#index"
  devise_for :users
  resources :search_params
  resources :users, only: [:show, :index]

  namespace :api do
    namespace :v1 do
      put "search_param_flats/:id", to: "search_param_flats#update"
      delete "search_params/:id", to: "search_params#destroy"
      post "search_params", to: "search_params#create"
      delete "users/:id", to: "users#destroy"
    end
  end
  # get "login", to: "sessions#new"
  # post "login", to: "sessions#create"
  # delete "logout", to: "sessions#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  ##### Sidekiq #######
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app


end
