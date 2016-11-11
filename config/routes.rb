Rails.application.routes.draw do
  root 'static#home'

  get '/about' => 'static#about'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

# shorthand routing - /users/id => /u/id
  get '/u/:id' => 'users#show'

  resources :users
end
