Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Commontator::Engine => '/commontator'

  devise_for :users

  root 'statuses#index'

  resources :users, constraints: { id: /.*/ }

  resources :groups do
    member do
      post :join
      get :can_join
      get :members
    end
  end

  resources :notifications, only: [:index] do
    member do
      get :read
    end
    collection do
      get :pull_unread
    end
  end

  resources :goals, only: [:show, :create, :new]
  get "goals/:id/:date", action: :on, as: :on, controller: :goals

  resources :statuses, only: [:show, :create, :update, :destroy] do
    resources :likes, only: [:create]
    resource :like, only: [:destroy]
  end

  get "/search", to: "search#index"
end
