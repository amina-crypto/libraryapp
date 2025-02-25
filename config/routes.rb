Rails.application.routes.draw do
  # Devise routes should come first
  devise_for :users
  
  # Root route
  root 'anonymous_users#home'

  # Anonymous Users Routes (rename the conflicting routes)
  resources :anonymous_users, only: [:new, :create] do
    collection do
      get :search
      get :home
    end
  end

  # Library User routes
  namespace :user do
    get 'dashboard', to: 'dashboard#index'
    resources :loans, only: [:index, :show]
    resources :reservations, only: [:index, :create, :destroy]
    resources :fines, only: [:index] do
      collection do
        get :history
      end
    end
  end

  # Library Personnel routes
  namespace :personnel do
    get 'dashboard', to: 'dashboard#index'
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
    get 'statistics', to: 'statistics#index'
  end

  # Shared resource routes
  resources :books, only: [:index, :show]
  resources :journals, only: [:index, :show]
  get 'search', to: 'search#index'

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Resources
  #resources :users
  resources :users, except: [:new, :create, :edit, :update, :destroy]

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
