Rails.application.routes.draw do
  
  root to: "homes#top"
 
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
}

  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
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
    
    get "top" => "customers#index"
    
    resources :customers, only: [:index, :show, :edit, :destroy]
    resources :items, only: [:index, :show, :edit, :destroy]
  
  end
  
  scope module: :customers do
    
    get   'inquiries'         => 'inquiries#index'     # 入力画面
    post  'inquiries/confirm' => 'inquiries#confirm'   # 確認画面
    post  'inquiries/thanks'  => 'inquiries#thanks'    # 送信完了画面
  
end
end