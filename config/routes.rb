Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout',  to: 'user_sessions#destroy'

  post 'guest_login', to: 'user_sessions#guest_login'

  resources :users, only: [:new, :create]
  resources :drummers, only: [:index] do
    collection do
      get 'search'
    end
  end
  # Defines the root path route ("/")
  root "tops#index"
end
