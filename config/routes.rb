Rails.application.routes.draw do
  get "signup", to: "users#new"
  resources :users, except: [:new]
  resources :search_params
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
