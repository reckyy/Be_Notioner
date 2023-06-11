Rails.application.routes.draw do
  root 'static_pages#top'
  
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  #お問合せフォーム
  get 'contact', to: 'static_pages#contact'
  get 'privacy', to: 'static_pages#privacy'
  get 'terms', to: 'static_pages#terms'
  get 'templates', to: 'static_pages#templates'

  resource :profile, only: %i[show edit update destroy]
  resources :users, only: %i[new create]
  resources :shortcuts, only: %i[index]
  resources :password_resets, only: %i[new create edit update]

  #/google_login_api/callbackに来るPOSTリクエストをcallbackアクションで
  post '/google_login_api/callback', to: 'google_login_api#callback'

  #letter_opener_webにアクセスするために
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  #sitemapへのルーティング
  get '/sitemap', to: redirect("https://s3-ap-northeast-1.amazonaws.com/#{ENV['S3_BUCKET_NAME']}/sitemaps/sitemap.xml.gz")
end
