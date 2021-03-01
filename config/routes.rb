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

  resources :posts  do
    resources :comments, only: [:create, :destory]
  end

  resources :favorites, only: [:create, :destroy]  
  resources :relationships, only: [:create, :destroy]
end
