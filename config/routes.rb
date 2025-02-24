Rails.application.routes.draw do
  devise_for :users
  # get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  #
  resources :users
  resources :library_resources
  resources :books
  resources :journals
  resources :categories
  resources :categorizations
  resources :reservations
  resources :loans
  resources :fines

  # API Endpoints
  namespace :api do
    resources :library_resources, defaults: { format: :json }
  end

  # root "library_resources#index"
  devise_for :users, controllers: { registrations: "users/registrations" }

  # Anonymous Users
  root to: "anonymous_users#home"
  get "search_resources", to: "anonymous_users#search"
  get "resource_details/:id", to: "anonymous_users#show", as: "resource_details"

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
