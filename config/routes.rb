Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "sessions#new"
  delete "sign_out" => "sessions#destroy"
  get "sign_out" => "sessions#destroy"
  get "sign_in" => "sessions#new"
  post "sign_in" => "sessions#create"
  get "sign_up" => "accounts#new"
  post "sign_up" => "accounts#create"
  get "dashboard" => "pages#dashboard"
  resources :accounts, only: [:create]
  resources :users
end
