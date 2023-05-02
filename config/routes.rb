Rails.application.routes.draw do
  root 'static_pages#top'
  
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  #お問合せフォーム
  get 'contact', to: 'static_pages#contact'
  get 'privacy', to: 'static_pages#privacy'
  get 'terms', to: 'static_pages#terms'

  resource :profile, only: %i[show edit update destroy]
  resources :users, only: %i[new create]
  resources :shortcuts, only: %i[index]
  resources :password_resets, only: %i[new create edit update]
end
