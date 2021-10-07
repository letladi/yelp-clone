Rails.application.routes.draw do
  root "reviews#index"
  namespace "ui" do
    %w(add_business add_business_category business_index home
       business_page index login sign_up user_page write_review).each do |action|
      get action, action: action
    end
  end
  get "register", to: "users#new"
  post "register", to: "users#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :categories, only: [:new, :create]
  resources :businesses, only: [:new, :index, :show, :create] do
    resources :reviews, only: [:new, :create]
  end
  resources :users, only: [:show]
end
