Rails.application.routes.draw do
  root "static_pages#show", page: "home"
  get "/static_pages/*page", to: "static_pages#show"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/signup", to: "users#create"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, except: :new
  resources :account_activations, only: :edit
end
