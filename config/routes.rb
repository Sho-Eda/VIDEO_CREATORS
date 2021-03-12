Rails.application.routes.draw do
  root to: 'toppages#index'
  post '/toppage/guest_sign_in', to: 'toppages#new_guest'

  get 'relationships/create'
  get 'relationships/destroy'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'

  resources :users, only: %i[index show create edit update] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end

  resources :posts do
    resources :comments, only: %i[create destroy]
    
    collection do
      get 'top'
      get 'get_category_children', defaults: { fomat: 'json'}
      get 'get_category_grandchildren', defaults: { fomat: 'json'}
      get 'name_search'
    end
    
    member do
      get 'search'
    end
  end

  resources :reels, only: %i[show new create destroy edit update]
  resources :favorites, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
end
