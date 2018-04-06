Rails.application.routes.draw do

  root "pages#home"

  delete '/logout', to: 'sessions#destroy'

  get '/chat', to: 'chatrooms#show'
  get 'pages/home', to: 'pages#home'
  get '/signup', to: 'chefs#new'
  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  resources :chefs, except: [:new]
  resources :ingredients, except: [:destroy]
  resources :messages, only: [:create]
  resources :recipes do
    resources :comments, only: [:create]
  end

  mount ActionCable.server => '/cable'

end
