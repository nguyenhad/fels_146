Rails.application.routes.draw do

  root "static_pages#home"
  get "home" => "static_pages#home"
  get "help"    => "static_pages#help"
  get "about"   => "static_pages#about"
  get "contact" => "static_pages#contact"

  get "login"  => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  get "signup"  => "users#new"

  resources :users do
    member do
      resources :followings, only: :index
      resources :followers, only: :index
    end
  end

  resources :categories, only: :index

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :categories, only: [:new, :create]
  end

  resources :relationships, only: [:create, :destroy]
end
