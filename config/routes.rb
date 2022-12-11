Rails.application.routes.draw do
 
  resources :users
  resources :lists
  root 'pages#home'
  resources :lists, only: [:show, :index, :new, :create]

  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :categories, except: [:destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

