Rails.application.routes.draw do
  resources :exercises
  resources :routines
  devise_for :users
  root 'routines#index'
end
