Rails.application.routes.draw do

  root 'static#home'

  resources :users
  resources :clients

  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get '/auth/facebook/callback', to: 'sessions#create'

end
