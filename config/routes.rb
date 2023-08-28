Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  get 'password_resets/new'
  get 'search/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout',  to: 'user_sessions#destroy'

  post 'guest_login', to: 'user_sessions#guest_login'

  get 'search/drummers', to: 'search#index'
  get '/drummers/:id/modal', to: 'drummers#modal', as: 'modal'
  get '/drummers/autocomplete', to: 'drummers#autocomplete'

  get '/recommended_drummers', to: 'recommended_drummers#index'

  post 'resend_activation', to: 'users#resend_activation'
  get 'resend_activation', to: 'users#resend_activation_form', as: :resend_activation_form

  get '/activate_email_change', to: 'account_settings#activate_email_change', as: 'activate_email_change'
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy] do
    member do
      get :activate
      get :likes
      get :favorites
    end
  end
  resources :account_settings, only: [:show, :edit, :update] do
    collection do
      get :password_confirmation
      post :check_password
      get :edit_password
      post :send_password_reset_link
      get :edit_email
      post :update_email
    end
  end

  resources :drummers, only: [:index, :show]
  resources :favorites, only: [:create, :destroy]
  resources :questions, only: [:index, :show]
  resources :user_answers, only: [:create]
  resources :posts do
    resources :comments, only: [:new, :create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  resources :password_resets, only: [:new, :create, :edit, :update]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # Defines the root path route ("/")
  root "tops#index"
end
