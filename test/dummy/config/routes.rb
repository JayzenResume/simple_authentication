Rails.application.routes.draw do
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get  '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    member do
      post :authorize, :unauthorize, :forbidden, :unforbidden
    end
    get 'search', on: :collection
  end
  root 'welcomes#index'
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :password_alters,     only: [:edit, :update]
  resources :portraits,           only: [:new, :create, :update]
  resources :articles do
    collection do
      delete :remove_select
      delete :remove_release
    end
    member do
      get :release, :unrelease
    end
  end
  get 'articles_search', to: "welcomes#articles_search"
  resources :categories
  resources :comments
  resources :notifications do
    get 'read', on: :collection
    get 'remove', on: :collection
  end
  resources :tags
end
