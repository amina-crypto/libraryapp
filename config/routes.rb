Rails.application.routes.draw do
  # Root route should be first
  root "home#index"

  # Devise routes
  devise_for :users

  # Library routes for anonymous users
  get "/library", to: "anonymous#index"
  get "/library/search", to: "anonymous#search"
  get "/library/resources/:id", to: "anonymous#show_resource", as: :library_resource
  post "/library/resources/:id/reserve", to: "reservations#create", as: :create_reservation
  get "/login", to: "sessions#new", as: :login
  get "/signup", to: "registrations#new", as: :signup

  # Protected routes
  authenticate :user do
    namespace :personnel do
      resources :resources
      resources :users
      resources :loans
    end

    namespace :user do
      resources :reservations
      resources :loans
    end
  end

  # Public routes (no authentication needed)
  resources :resources, only: [ :index, :show, :search ] do
    collection do
      get :search
    end
  end

  # Library User routes
  namespace :user do
    get "dashboard", to: "dashboard#index"
    resources :loans, only: [ :index, :show ]
    resources :reservations, only: [ :index, :create, :destroy ]
    resources :fines, only: [ :index ] do
      collection do
        get :history
      end
    end
  end

  # Library Personnel routes
  namespace :personnel do
    get "dashboard", to: "dashboard#index"
    resources :library_resources do
      collection do
        get :overdue
        get :low_stock
      end
    end
    resources :users
    resources :loans do
      member do
        patch :return
        patch :process_fine
      end
      get :overdue, on: :collection
    end
    resources :reservations do
      member do
        patch :approve
        patch :reject
      end
    end
    resources :fines do
      member do
        patch :mark_as_paid
      end
      collection do
        get :outstanding
      end
    end
    get "statistics", to: "statistics#index"
  end

  # Shared resource routes
  resources :books, only: [ :index, :show ]
  resources :journals, only: [ :index, :show ]
  get "search", to: "search#index"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Resources
  # resources :users
  resources :users, except: [ :new, :create, :edit, :update, :destroy ]

  resources :library_resources
  resources :categories
  resources :categorizations

  # API Endpoints
  namespace :api do
    resources :library_resources, defaults: { format: :json }
  end

  # API Endpoints for anonymous access
  namespace :api do
    resources :library_resources, only: [ :index, :show ], defaults: { format: :json }
    get "search", to: "library_resources#search"
  end

  # Library Users
  authenticated :user, ->(u) { u.is_a?(LibraryUser) } do
    root to: "library_users#dashboard", as: :library_user_root
    get "profile", to: "library_users#profile"
    get "borrowed_books", to: "library_users#borrowed_books"
    post "reserve/:id", to: "library_users#reserve", as: "reserve_book"
  end

  # Library Personnel
  authenticated :user, ->(u) { u.is_a?(LibraryPersonnel) } do
    root to: "library_personnel#dashboard", as: :library_personnel_root
    get "manage_books", to: "library_personnel#manage_books"
    get "manage_users", to: "library_personnel#manage_users"
    post "add_book", to: "library_personnel#add_book"
    post "remove_book/:id", to: "library_personnel#remove_book", as: "remove_book"
  end
end
