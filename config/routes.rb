Rails.application.routes.draw do

  root 'static#home'

  get '/auth/facebook/callback' => 'sessions#create'
  
end
