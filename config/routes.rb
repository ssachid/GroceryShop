Rails.application.routes.draw do
  get 'welcome/home'
  root "welcome#home"

  get '/signup', to: "users#new"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  resources :users, except: [:new, :destroy]
end
