Rails.application.routes.draw do
  root 'static#home'

  get '/about' => 'static#about'
  get '/contact' => 'static#contact'
  get '/adduser' => 'users#new'
  post '/adduser' => 'users#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

# shorthand routing - /users/id => /u/id
  get '/u/:id' => 'users#show'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :schools
end
