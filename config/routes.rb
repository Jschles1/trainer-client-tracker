Rails.application.routes.draw do

  root 'static#home'
  get '/dashboard', to: 'static#dashboard', as: 'dashboard'

  resources :users do
    # resources :appointments, only: [:index]
    resources :clients, only: [:new]
  end

  resources :clients, only: [:create, :edit, :update, :index, :show, :destroy] do
    resources :appointments, only: [:edit]
  end

  resources :notes, only: [:index, :create]

  delete '/notes', to: 'notes#destroy'

  resources :appointments, only: [:index, :update]
  resources :sessions, only: [:create]

  get 'clients/:id/appointment_complete', to: 'clients#appointment_complete', as: 'appointment_complete'
  patch 'clients/:id/update_progress', to: 'clients#update_progress', as: 'update_progress'

  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get '/auth/facebook/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
end
