Rails.application.routes.draw do
  devise_for :users

  root 'statuses#index'

  resources :users

  resources :monthly_goals

  resources :weekly_goals

  resources :daily_goals

  resources :statuses do
    resources :likes, only: [:create]
    resource :like, only: [:destroy]
  end

end
