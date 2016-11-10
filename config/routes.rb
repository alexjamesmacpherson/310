Rails.application.routes.draw do
  root 'static#home'

  get '/about' => 'static#about'
  get '/login' => 'static#login'
end
