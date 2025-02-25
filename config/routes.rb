Rails.application.routes.draw do
  # Set root to resources index for anonymous access
  root 'resources#index'
  
  # Devise routes
  devise_for :users
  
  # Public routes (no authentication needed)
  resources :resources, only: [:index, :show, :search] do
    collection do
      get :search
    end
  end
  
  # Protected routes (need authentication)
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
