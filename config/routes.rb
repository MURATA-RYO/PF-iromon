Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
}

  devise_for :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get "/home/about" => "homes#about"
  get 'search' => 'searches#search'

  resources :tags do
    get 'items', to: 'items#search'
    #get 'tags' => 'tags#search'
end

  resources :items do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :customers do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    member do
      get :following, :followers
    end
  end
  
  namespace :admins do
    
    # get "top" => "customers#index"
    
    resources :customers, only: [:index, :show, :edit, :destroy]
    resources :items, only: [:index, :show, :edit, :destroy]
  
  end
end
