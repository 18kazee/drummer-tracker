Rails.application.routes.draw do
  get 'search/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout',  to: 'user_sessions#destroy'

  post 'guest_login', to: 'user_sessions#guest_login'

  get 'search/drummers', to: 'search#index'

  resources :users, only: [:new, :create]
  resources :drummers, only: [:index, :show]
  # Defines the root path route ("/")
  root "tops#index"
end
