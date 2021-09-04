Rails.application.routes.draw do
  get 'oauths/oauth'
  get 'oauths/callback'
  root to: 'static_pages#home'
  resources :charts do
    collection do
      get :levels
      get :ran_levels
      get :s_ran_levels
      get :ran_index
      get :s_ran_index
    end
  end
  resources :results
  resources :users
  namespace :admin do
    get 'login', to: 'user_sessions#new', as: :login
    post 'login', to: 'user_sessions#create'
    post 'logout', to: 'user_sessions#destroy', as: :logout
    resources :information
    resources :musics do
      collection { get :remain }
      collection { post :csv_import }
      resources :charts
    end
    resources :materials
  end
  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  post 'logout', to: 'user_sessions#destroy', as: :logout
  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
