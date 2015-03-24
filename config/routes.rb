Rails.application.routes.draw do
  devise_for :users

  root 'statuses#index'

  resources :users

  resource :goals, only: [:create] do
    get 'season', on: :new
  end

  resources :monthly_goals

  resources :weekly_goals

  resources :daily_goals

  resources :statuses do
    resources :likes, only: [:create]
    resource :like, only: [:destroy]
  end

end
