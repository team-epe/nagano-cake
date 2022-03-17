Rails.application.routes.draw do
  root to: 'public/homes#top'
  get "/homes/about" => "homes#about", as: "about"
  namespace :admin do
    resources :items, only: [:create, :index, :new, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :update, :edit]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
    resources :sessions, only: [:new, :create, :destroy]
    root to: 'homes#top'
  end
  namespace :public do
    resources :items, only: [:index, :show]
    resources :cart_item, only: [:index, :create, :update, :destroy, :destroy_all]
    resources :customers, only: [:show, :edit, :update, :unsubscribe, :withdrow]
    resources :orders, only: [:new, :create, :check, :complete, :index, :show]
    resources :sessions, only: [:new, :create, :destroy]
    root to: 'homes#top'
    resources :address, only: [:index, :destroy, :edit, :update, :create]
    resources :registrations, only: [:new, :create]
  end  
    
  
  # 会員側のルーティング設定
  get 'items' => 'public/items#index'
  # 管理者側のルーティング設定
  namespace :admin do
    get 'items' => 'admin/items#index'
  end
  
 # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
