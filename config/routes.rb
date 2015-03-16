Rails.application.routes.draw do

  resources :statuses

  devise_for :users

  resources :users

  resources :monthly_goals

  resources :weekly_goals

  resources :daily_goals
end
