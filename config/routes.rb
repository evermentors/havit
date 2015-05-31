Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Commontator::Engine => '/commontator'

  devise_for :users

  root 'statuses#index'

  resources :users, constraints: { id: /.*/ }

  resources :characters

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

  resource :goals, only: [:create]

  resources :monthly_goals, only: [:edit, :update, :destroy]

  resources :weekly_goals, only: [:create, :edit, :update, :destroy]

  resources :daily_goals, only: [:create, :edit, :update, :destroy]

  resources :statuses, only: [:show, :create, :update, :destroy] do
    resources :likes, only: [:create]
    resource :like, only: [:destroy]
  end

  resources :weekly_retrospects do
    collection do
      constraints year: /\d{4}/, month: /(0?[1-9]|1[012])/ do
        get "/:year/:month", action: :monthly, as: :monthly
        # get "/:year", action: :yearly, as: :yearly
      end
    end
  end

  get "daily_goals/:date", action: :on, as: :on, controller: :daily_goals

  get "/search", to: "search#index"
end
