Rails.application.routes.draw do

  root 'static#home'

  resources :users
  resources :clients do
    resources :appointments, only: [:edit]
  end
  resources :appointments, only: [:index, :update]
  resources :sessions, only: [:create]

  get 'clients/:id/appointment_complete', to: 'clients#appointment_complete', as: 'appointment_complete'
  patch 'clients/:id/update_progress', to: 'clients#update_progress', as: 'update_progress'

  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get '/auth/facebook/callback', to: 'sessions#create'

end
