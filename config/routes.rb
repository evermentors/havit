Rails.application.routes.draw do

  devise_for :users

  resources :users

  resources :monthly_goals

  resources :weekly_goals
end
