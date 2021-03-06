Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'relationships/create'
  get 'relationships/destroy'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'

  resources :users, only: [:index, :show, :create, :edit, :update] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end  

  post '/guest', to: 'guest_sessions#create'

  resources :posts  do
    # member do
    #   get '/download', to: "posts#download"
    # end

    resources :comments, only: [:create, :destroy]
  end

  resources :reels, only: [:show, :new, :create, :destroy, :edit, :update]

  resources :favorites, only: [:create, :destroy]  
  resources :relationships, only: [:create, :destroy]
end
