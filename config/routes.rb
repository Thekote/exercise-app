Rails.application.routes.draw do
  resources :exercises
  resources :routines
  devise_for :users, controllers: { confirmations: 'confirmations' }
  root 'routines#index'
end
