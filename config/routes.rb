Rails.application.routes.draw do
  root 'static#home'

  get '/about' => 'static#about'
  get '/login' => 'static#login'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  resources :users
end
